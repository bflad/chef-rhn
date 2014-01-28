# chef-rhn [![Build Status](https://secure.travis-ci.org/bflad/chef-rhn.png?branch=master)](http://travis-ci.org/bflad/chef-rhn)

## Description

Registers node with Red Hat Network (rhn.redhat.com or RHN Satellite)

_THIS COOKBOOK HAS ONLY BEEN TESTED WITH RHN SATELLITE_

## Requirements

Active RHN subscription for node and at least one activation key.

### Platforms

* RedHat 6.3

### Cookbooks

* None

## Attributes

* `node['rhn']['activation_keys']` - comma separated RHN activation keys, at
  least one activation key required
* `node['rhn']['hostname']` - default of "rhn.redhat.com" or RHN Satellite
* `node['rhn']['allow_config_actions']` - allow RHN configuration actions,
  defaults to true
* `node['rhn']['allow_remote_commands']` - allow RHN to perform remote commands
  defaults to true
* `node['rhn']['client_overrides']` - Node RHN override settings, defaults to
  "client-config-overrides.txt"
* `node['rhn']['fully_update']` - Fully update node after bootstrap, defaults to
  true
* `node['rhn']['gpg']` - use GPG security with RHN repositories, defaults to
  true
* `node['rhn']['org_ca_cert']` - RHN organization SSL certificate RPM or file,
  defaults to "rhn-org-trusted-ssl-cert-1.0-3.noarch.rpm"
* `node['rhn']['org_gpg_key']` - RHN GPG key, defaults to not used
* `node['rhn']['register']` - Register node with RHN during bootstrap, defaults
  to true
* `node['rhn']['ssl']` - Use SSL with RHN, defaults to true

## Recipes

* `recipe[rhn]` - performs node RHN bootstrap

## Usage

* Add at least one activation key to `node['rhn']['activation_keys']`
* Add `recipe[rhn]` to your run_list

### RHN Satellite

* Add your RHN Satellite FQDN to `node['rhn']['hostname']` attribute.

## Testing and Development

* Quickly testing with Vagrant: [VAGRANT.md](VAGRANT.md)
* Full development and testing workflow with Test Kitchen and friends: [TESTING.md](TESTING.md)

## Contributing

Please see contributing information in: [CONTRIBUTING.md](CONTRIBUTING.md)

## Maintainers

* Brian Flad (<bflad417@gmail.com>)

## License

Please see licensing information in: [LICENSE](LICENSE)
