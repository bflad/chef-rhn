package 'rhncfg'

template '/etc/sysconfig/rhn/rhncfg-client.conf' do
  source 'rhncfg-client.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
