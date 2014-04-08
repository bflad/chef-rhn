require 'spec_helper'

describe 'rhn::org_gpg_key' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
