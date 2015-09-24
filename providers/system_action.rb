require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
include Helpers::Rhn

def load_current_resource
  @current_resource = Chef::Resource::RhnSystemAction.new(new_resource)
  if new_resource.action_name == 'run'
    @current_resource.enabled(true) if ::File.exist?('/etc/sysconfig/rhn/allowed-actions/script/run')
  else
    @current_resource.enabled(true) if ::File.exist?("/etc/sysconfig/rhn/allowed-actions/configfiles/#{new_resource.action_name}")
  end
  @current_resource
end

action :disable do
  if enabled?
    disable
    new_resource.updated_by_last_action(true)
  end
end

action :enable do
  unless enabled?
    enable
    new_resource.updated_by_last_action(true)
  end
end

def disable
  disable_args = cli_args(
    "disable-#{new_resource.action_name}" => true,
    'force' => true
  )
  execute_cmd("rhn-actions-control #{disable_args}")
end

def enabled?
  @current_resource.enabled
end

def enable
  enable_args = cli_args(
    "enable-#{new_resource.action_name}" => true,
    'force' => true
  )
  execute_cmd("rhn-actions-control #{enable_args}")
end

def execute_cmd(cmd)
  Chef::Log.debug('Executing: ' + cmd)
  shell_out!(cmd)
end
