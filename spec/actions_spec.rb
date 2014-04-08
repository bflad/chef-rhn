require 'spec_helper'

describe 'rhn::actions' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
