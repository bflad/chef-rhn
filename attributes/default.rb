#
# Cookbook Name:: rhn
# Attributes:: rhn
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# At least one activation key required
default['rhn']['activation_keys'] = ""
# rhn.redhat.com or RHN Satellite
default['rhn']['hostname'] = "rhn.redhat.com"

default['rhn']['allow_config_actions']  = true
default['rhn']['allow_remote_commands'] = true
default['rhn']['client_overrides']      = "client-config-overrides.txt"
default['rhn']['fully_update']          = true
default['rhn']['gpg']                   = true
default['rhn']['org_ca_cert']           = "rhn-org-trusted-ssl-cert-1.0-3.noarch.rpm"
default['rhn']['org_gpg_key']           = ""
default['rhn']['register']              = true
default['rhn']['ssl']                   = true
