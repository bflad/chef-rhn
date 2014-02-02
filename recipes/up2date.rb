template '/etc/sysconfig/rhn/up2date' do
  source 'up2date.erb'
  owner 'root'
  group 'root'
  mode '0600'
end
