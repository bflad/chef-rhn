require 'spec_helper'

describe 'rhn::org_ca_cert' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
