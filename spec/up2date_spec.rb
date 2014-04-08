require 'spec_helper'

describe 'rhn::up2date' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
