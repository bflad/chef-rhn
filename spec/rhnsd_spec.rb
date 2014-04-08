require 'spec_helper'

describe 'rhn::rhnsd' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
