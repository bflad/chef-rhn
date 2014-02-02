package 'rhncfg-actions'

node['rhn']['actions']['enabled'].each do |system_action|
  rhn_system_action system_action
end

node['rhn']['actions']['disabled'].each do |system_action|
  rhn_system_action system_action do
    action :disable
  end
end
