provides :rhn_channel
actions :enable, :disable
default_action :enable

attribute :channel_name, kind_of: String, name_attribute: true
attribute :username, kind_of: [String, NilClass], default: nil
attribute :password, kind_of: [String, NilClass], default: nil
