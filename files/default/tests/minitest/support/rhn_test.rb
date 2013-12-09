require 'minitest/autorun'

describe_recipe 'rhn::default' do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
end
