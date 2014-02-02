actions :register

default_action :register

attribute :profile_name, :name_attribute => true

attribute :activation_keys, :kind_of => [String], :default => node['rhn']['activation_keys']
attribute :cmd_timeout, :kind_of => [Integer], :default => node['rhn']['cmd_timeout']
attribute :hostname, :kind_of => [String], :default => node['rhn']['hostname']
attribute :password, :kind_of => [String], :default => node['rhn']['password']
attribute :system_id, :kind_of => [String]
attribute :username, :kind_of => [String], :default => node['rhn']['username']
