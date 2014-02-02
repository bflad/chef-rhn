unless node['rhn']['hostname'] == 'xmlrpc.rhn.redhat.com'
  include_recipe 'rhn::org_gpg_key' if node['rhn']['org_gpg_key']['url']
  include_recipe 'rhn::org_ca_cert' if node['rhn']['ssl']
end

include_recipe 'rhn::up2date'
include_recipe 'rhn::register' if node['rhn']['register']

unless node['rhn']['actions']['disabled'].empty? && node['rhn']['actions']['enabled'].empty?
  include_recipe 'rhn::rhncfg'
  include_recipe 'rhn::actions'
end

include_recipe 'rhn::rhnsd' if node['rhn']['rhnsd']['enabled']
