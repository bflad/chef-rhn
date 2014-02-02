actions :disable, :enable

default_action :enable

attribute :action_name, :name_attribute => true

# Internal attributes
attribute :enabled, :kind_of => [TrueClass, FalseClass]
