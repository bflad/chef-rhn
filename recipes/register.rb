rhn_system node['hostname'] do
  hostname node['rhn']['hostname']
  activation_keys node['rhn']['activation_keys']
end
