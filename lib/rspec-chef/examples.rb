require 'rspec-chef/examples/define_recipe_group.rb'

RSpec.configure do |c|
  def c.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]'))
  end

  c.include RSpec::Chef::DefineRecipeGroup, :type => :recipe, :example_group => {
    :file_path => c.escaped_path(%w[spec recipes])
  }
end
