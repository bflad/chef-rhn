# chef-rhn [![Build Status](https://secure.travis-ci.org/bflad/chef-rhn.png?branch=master)](http://travis-ci.org/bflad/chef-rhn)

## Description

Registers node with Red Hat Network (rhn.redhat.com or RHN Satellite) and configures client.

## Requirements

Active RHN system entitlement for node.

### Platforms

* RHEL 5
* RHEL 6

### Cookbooks

* None

## Usage

### Register Node with Hosted RHN (rhn.redhat.com)

Securely with encrypted data bag:
* Create wrapper cookbook which:
  * Sets `node['rhn']['register']` to false
  * Reads encrypted data bag
  * Calls default recipe (or customize)
  * Calls `rhn_system` LWRP

Less securely with attributes:
* Set `node['rhn']['username']` and `node['rhn']['password']`
* Add `recipe[rhn]` to your run_list

### Register Node with RHN Satellite (satellite.example.com)

* Add at least one activation key to `node['rhn']['activation_keys']`
* Set your RHN Satellite FQDN in `node['rhn']['hostname']`
* Add `recipe[rhn]` to your run_list

## Attributes

These attributes are under the `node['rhn']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
activation_keys | Comma-separated activation keys for Satellite registration | String | nil
cmd_timeout | Timeout in seconds for remote RHN commands | Fixnum | 300
hostname | Hosted RHN XMLRPC hostname or your RHN Satellite hostname | String | xmlrpc.rhn.redhat.com
password | RHN password for hosted RHN operations | String | changeme
register | Register system with RHN | Boolean | true
retries | Network retries for package commands | Fixnum | 1
ssl | Enable SSL | Boolean | true
username | RHN username for hosted RHN operations | String | rhnuser

### Actions Attributes

These attributes are under the `node['rhn']['actions']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
disabled | RHN allowed system actions to be disabled | Array of Strings | []
enabled | RHN allowed system actions to be enabled | Array of Strings | []

### Organization CA Certificate Attributes

These attributes are under the `node['rhn']['org_ca_cert']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
action | Only install or upgrade CA certificate | String | install
name | Filename of certificate | String | RHNS-CA-CERT
url | URL to certificate file or RPM for CA certificate | String | `https://#{node['rhn']['hostname']}/pub/#{node['rhn']['org_ca_cert']['name']}`

### Organization GPG Key Attributes

These attributes are under the `node['rhn']['org_gpg_key']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
name | Filename of GPG key | String | ORG-GPG-KEY
pub | GPG public key signature | String | nil
url | URL for GPG key | String | nil

### Proxy Attributes

These attributes are under the `node['rhn']['proxy']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
password | Password for authenticated RHN HTTP proxying | String | nil
url | hostname:port for RHN HTTP proxy | String | nil
username | Username for authenticated RHN HTTP proxying | String | nil

### RHN Config Client Attributes

These attributes are under the `node['rhn']['rhncfg-client']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
server_url | Custom URL for config client | String | https://%(server_name)s%(server_handler)s
script_log_file_enable | Enable action logging | Boolean | false

### RHN Sync Daemon Attributes

These attributes are under the `node['rhn']['rhnsd']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
enabled | Enable sync daemon | Boolean | false
interval | Sync interval in minutes (must be above 60) | Fixnum | 240

## LWRPs

* system: Register node with RHN
* system_action: Enable/disable RHN system action on node

### rhn_system

Below are the available actions for the LWRP, default being `register`.

These attributes are associated with all LWRP actions.

Attribute | Description | Type | Default
----------|-------------|------|--------
cmd_timeout | Timeout for remote RHN commands (catchable exception: `Chef::Provider::RhnSystem::CommandTimeout`)| Fixnum | `node['rhn']['cmd_timeout']`

#### rhn_system action :register

These attributes are associated with this LWRP action. The name attribute will set the RHN profile name on registration.

Attribute | Description | Type | Default
----------|-------------|------|--------
activation_keys | Activation keys for RHN Satellite registration | String | `node['rhn']['activation_keys']`
hostname | Hostname passthrough to determine hosted versus RHN Satellite registration | String | `node['rhn']['hostname']`
password | Password for hosted RHN | String | `node['rhn']['password']`
username | Username for hosted RHN | String | `node['rhn']['username']`

Register with hosted RHN with hostname as profile name and possibly username/password from an encrypted data bag:

```
rhn_system node['hostname'] do
  password 'myPasswordFromDataBag'
  username 'myUsernameFromDataBag'
end
```

Register with hosted RHN or Satellite with custom profile name:

```
rhn_system 'special-snowflake'
```

### rhn_system_action

Below are the available actions for the LWRP, default being `enable`.

#### rhn_system_action action :disable

The name attribute is the RHN system action name.

Disable run action from node:

```
rhn_system_action 'run' do
  action :disable
end
```

#### rhn_system_action action :enable

The name attribute is the RHN system action name.

Enable run action on node:

```
rhn_system_action 'run'
```

Enable all actions on node:

```
rhn_system_action 'all'
```

## Recipes

* `recipe[rhn]` - RHN client configuration and system registration
* `recipe[rhn::actions]` - configures RHN system actions on client
* `recipe[rhn::org_ca_cert]` - installs organization CA certificate
* `recipe[rhn::org_gpg_key]` - installs organization GPG key
* `recipe[rhn::register]` - registers node with hosted RHN or Satellite
* `recipe[rhn::rhncfg]` - configures RHN client configuration
* `recipe[rhn::rhnsd]` - configures RHN sync daemon
* `recipe[rhn::up2date]` - configures up2date

## Testing and Development

* Quickly testing with Vagrant: [VAGRANT.md](VAGRANT.md)
* Full development and testing workflow with Test Kitchen and friends: [TESTING.md](TESTING.md)

## Contributing

Please see contributing information in: [CONTRIBUTING.md](CONTRIBUTING.md)

## Maintainers

* Brian Flad (<bflad417@gmail.com>)

## License

Please see licensing information in: [LICENSE](LICENSE)
