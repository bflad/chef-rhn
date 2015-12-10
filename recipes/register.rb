rhn_system node['rhn']['profilename'] do
  hostname node['rhn']['hostname']
  activation_keys node['rhn']['activation_keys']
end
