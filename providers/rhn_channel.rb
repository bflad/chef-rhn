use_inline_resources

action :enable do
  execute "#{new_resource.name} :join #{new_resource.channel_name}" do
    sensitive true
    command rhn_cmd('-a')
    not_if { channel_enabled? }
  end
end

action :disable do
  execute "#{new_resource.name} :unjoin #{new_resource.channel_name}" do
    sensitive true
    command rhn_cmd('-r')
    only_if { channel_enabled? }
  end
end

def channel_enabled?
  node['rhn']['channels'].include? new_resource.channel_name.to_s
rescue
  false
end

# rubocop:disable Metrics/AbcSize
def rhn_cmd(args)
  options = {}
  options['-u'] = new_resource.username unless new_resource.username.nil?
  options['-p'] = new_resource.password unless new_resource.password.nil?
  options['-c'] = new_resource.channel_name
  ['rhn-channel', args, options.map { |k, v| "#{k} '#{v}'" }].flatten.join(' ')
end
# rubocop:enable Metrics/AbcSize
