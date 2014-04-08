require 'spec_helper'

describe 'rhn::register' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
