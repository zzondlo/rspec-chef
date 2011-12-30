module RSpec
  module Chef
    module DefineRecipeGroup
      include RSpec::Chef::Matchers
      include JSONSupport
      include ChefSupport

      def subject
        @recipe ||= recipe
      end

      def recipe
        ::Chef::Config[:solo] = true
        ::Chef::Config[:cookbook_path] = self.respond_to?(:cookbook_path) ? cookbook_path : RSpec.configuration.cookbook_path
        dna = json(self.respond_to?(:json_attributes) ? json_attributes : RSpec.configuration.json_attributes)

        cookbook_name = self.class.top_level_description.downcase

        lookup_recipe(cookbook_name, ::Chef::Config[:cookbook_path], dna)
      end
    end
  end
end
