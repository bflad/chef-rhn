require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
include Helpers::Rhn

class CommandTimeout < RuntimeError; end

def load_current_resource
  @current_resource = Chef::Resource::RhnSystem.new(new_resource)
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

def registered?
  registered = false
  cmd = Mixlib::ShellOut.new('/usr/sbin/rhn-profile-sync')
  begin cmd.run_command
    rescue Errno::ENOENT
  end
  registered = true unless cmd.error?
  registered
end

def register
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
        'activationkey' => new_resource.activation_keys,
        'force' => true,
        'profilename' => new_resource.profile_name
      )
    end
  execute_cmd("rhnreg_ks #{register_args}")
end
