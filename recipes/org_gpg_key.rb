remote_file "/etc/pki/rpm-gpg/#{node['rhn']['org_gpg_key']['name']}" do
  source node['rhn']['org_gpg_key']['url']
  owner 'root'
  group 'root'
  mode '0644'
end

execute "rpm-import-#{node['rhn']['org_gpg_key']['name']}" do
  command "rpm --import /etc/pki/rpm-gpg/#{node['rhn']['org_gpg_key']['name']}"
  not_if "rpm -qa | grep 'gpg-pubkey-*-#{node['rhn']['org_gpg_key']['pub']}'"
  action :run
end
