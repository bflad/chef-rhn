template '/etc/sysconfig/rhn/rhnsd' do
  source 'rhnsd.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'rhnsd' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
  subscribes :restart, "template[/etc/sysconfig/rhn/rhnsd]", :delayed
end
