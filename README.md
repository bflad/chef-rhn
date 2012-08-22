# DESCRIPTION:

Registers node with Red Hat Network (rhn.redhat.com or RHN Satellite)

_NOTE: THIS COOKBOOK IS CURRENTLY UNDER HEAVY ACTIVE DEVELOPMENT_
_AND NOT RECOMMENDED FOR EVEN BETA TESTING YET._

# REQUIREMENTS:

Active RHN subscription for node and at least one activation key.

# USAGE:

In a node role:
```
default_attributes=(
  "rhn" => {
    "activation_keys" = "THIS-IS-REQUIRED"
  }
)
run_list(
  "recipe[rhn]"
)
```

See the default cookbook attributes for more settings.

### RHN Satellite

Add at least your RHN Satellite FQDN to "hostname" attribute.

# LICENSE and AUTHOR:
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
