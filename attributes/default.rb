default['rhn']['activation_keys'] = nil
default['rhn']['cmd_timeout'] = 300
default['rhn']['hostname'] = 'xmlrpc.rhn.redhat.com'
default['rhn']['password'] = 'changeme'
default['rhn']['register'] = true
default['rhn']['retries'] = 1
default['rhn']['ssl'] = true
default['rhn']['username'] = 'rhnuser'
default['rhn']['profilename'] = node['hostname'] || node['fqdn']

default['rhn']['actions']['disabled'] = []
default['rhn']['actions']['enabled'] = []

default['rhn']['org_ca_cert']['action'] = 'install'
default['rhn']['org_ca_cert']['name'] = 'RHNS-CA-CERT'
default['rhn']['org_ca_cert']['url'] = "https://#{node['rhn']['hostname']}/pub/#{node['rhn']['org_ca_cert']['name']}"

default['rhn']['org_gpg_key']['name'] = 'ORG-GPG-KEY'
default['rhn']['org_gpg_key']['pub'] = nil
default['rhn']['org_gpg_key']['url'] = nil

default['rhn']['proxy']['password'] = nil
default['rhn']['proxy']['url'] = nil
default['rhn']['proxy']['username'] = nil

default['rhn']['rhncfg-client']['server_url'] = 'https://%(server_name)s%(server_handler)s'
default['rhn']['rhncfg-client']['script_log_file_enable'] = false

default['rhn']['rhnsd']['enabled'] = false
default['rhn']['rhnsd']['interval'] = 240
