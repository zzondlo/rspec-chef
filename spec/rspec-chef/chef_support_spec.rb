require File.expand_path('../spec_helper', File.dirname(__FILE__))

class RSpecChefSupport
  include RSpec::Chef::ChefSupport
end

describe RSpecChefSupport do
  it "returns the default recipe if we only provide the cookbook name" do
    recipe = subject.lookup_recipe('foo', COOKBOOKS, {})
    recipe.recipe_name.should == 'default'
  end

  it "returns the specific recipe if we provide its name" do
    recipe = subject.lookup_recipe('foo::install', COOKBOOKS, {:path => 'foo'})
    recipe.recipe_name.should == 'install'
  end
end
