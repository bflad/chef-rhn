if node['rhn']['activation_keys'].empty?
  Chef::Log.error('RHN Activation Key missing, skipping RHN bootstrap.')
else
  directory '/usr/local/src/rhn_setup' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  template '/usr/local/src/rhn_setup/bootstrap.sh' do
    source 'bootstrap.sh.erb'
    owner  'root'
    group  'root'
    mode   '0755'
  end

  execute "RHN Bootstrapping to #{node['rhn']['hostname']}" do
    cwd Chef::Config[:file_cache_path]
    command '/usr/local/src/rhn_setup/bootstrap.sh'
    not_if "grep -q #{node['hostname']} /etc/sysconfig/rhn/systemid"
  end
end
