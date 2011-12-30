module RSpec
  module Chef
    module ChefSupport
      def lookup_recipe(cookbook_name, cookbook_path, dna)
        recipe_name = ::Chef::Recipe.parse_recipe_name(cookbook_name)

        cookbook_collection = ::Chef::CookbookCollection.new(::Chef::CookbookLoader.new(cookbook_path))
        node = ::Chef::Node.new
        node.consume_attributes(dna)

        run_context = ::Chef::RunContext.new(node, cookbook_collection)

        cookbook = run_context.cookbook_collection[recipe_name[0]]
        cookbook.load_recipe(recipe_name[1], run_context)
      end
    end
  end
end
