# At least one activation key required
default['rhn']['activation_keys'] = ''
# rhn.redhat.com or RHN Satellite
default['rhn']['hostname'] = 'rhn.redhat.com'

default['rhn']['allow_config_actions']  = true
default['rhn']['allow_remote_commands'] = true
default['rhn']['client_overrides']      = 'client-config-overrides.txt'
default['rhn']['fully_update']          = true
default['rhn']['gpg']                   = true
default['rhn']['org_ca_cert']           = 'rhn-org-trusted-ssl-cert-1.0-3.noarch.rpm'
default['rhn']['org_gpg_key']           = ''
default['rhn']['register']              = true
default['rhn']['ssl']                   = true
