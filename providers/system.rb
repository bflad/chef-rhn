require 'chef/mixin/shell_out'
require 'xmlrpc/client'
include Chef::Mixin::ShellOut
include Helpers::Rhn

class CommandTimeout < RuntimeError; end

def load_current_resource
  @current_resource = new_resource.class.new(new_resource.name)
  if ::File.exist?('/etc/sysconfig/rhn/systemid')
    systemid = {}
    require 'rexml/document'
    systemid_xml = REXML::Document.new(::File.open('/etc/sysconfig/rhn/systemid', 'r'))
    systemid_xml.root.each_element('param/value/struct/member') do |e|
      next if e.elements['name'].text == 'fields'
      systemid.merge!(e.elements['name'].text => e.elements['value'].elements['string'].text)
    end
    @current_resource.profile_name(systemid['profile_name'])
    @current_resource.system_id(systemid['system_id'])
  end
  @current_resource
end

action :register do
  unless registered?
    register
    reactivation_key
    new_resource.updated_by_last_action(true)
  end
end

def execute_cmd(cmd, timeout = new_resource.cmd_timeout)
  Chef::Log.debug('Executing: ' + cmd)
  begin
    shell_out!(cmd, :timeout => timeout)
  rescue Mixlib::ShellOut::CommandTimeout
    raise CommandTimeout, <<-EOM

Command timed out:
#{cmd}

Please adjust node['rhn']['cmd_timeout'] attribute or this rhn_system cmd_timeout attribute if necessary.
EOM
  end
end

def execute_cmd_with_retries(cmd, tries, timeout = new_resource.cmd_timeout)
  Chef::Log.info("Executing: #{cmd}, #{tries} tries remaining.")
  raise SystemError, "#{cmd} -- too many failures. Aborting!" if tries == 0
  begin
    execute_cmd(cmd, :timeout => timeout)
  rescue
    execute_cmd_with_retries(cmd, tries - 1)
  end
end

def registered?
  registered = false
  cmd = Mixlib::ShellOut.new('/usr/sbin/spacewalk-channel --list')
  begin cmd.run_command
    rescue Errno::ENOENT
  end
  if cmd.error?
    puts "spacewalk-channel failed with STDOUT: #{cmd.stdout} STDERR: #{cmd.stderr}"
    registered = false
  else
    registered = true
  end
  registered
end

def register
  keys = String.new
  if ::File.exist?('/etc/sysconfig/rhn/reactivation_key')
    my_reactivation_key = ::File.read('/etc/sysconfig/rhn/reactivation_key').chomp
    keys = "#{my_reactivation_key}," unless my_reactivation_key.nil?
    ::File.unlink('/etc/sysconfig/rhn/reactivation_key')
  end

  keys << new_resource.activation_keys unless new_resource.activation_keys.nil?

  register_args =
    if new_resource.hostname == 'xmlrpc.rhn.redhat.com'
      cli_args(
        'force' => true,
        'password' => new_resource.password,
        'profilename' => new_resource.profile_name,
        'username' => new_resource.username
      )
    else
      cli_args(
        'activationkey' => keys,
        'force' => true,
        'profilename' => new_resource.profile_name
      )
    end
  execute_cmd_with_retries("rhnreg_ks #{register_args}", new_resource.reg_retries)
end

def reactivation_key
  puts 'Generating Reactivation Key'
  my_server = XMLRPC::Client.new(new_resource.hostname, "/rpc/api")
  key = my_server.call('system.obtainReactivationKey', ::File.read('/etc/sysconfig/rhn/systemid'))
  open('/etc/sysconfig/rhn/reactivation_key', 'w') { |f|
    f.puts key
  }
end
