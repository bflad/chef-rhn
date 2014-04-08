require 'spec_helper'

describe 'rhn::rhncfg' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
