# RSpec matchers and examples for your Chef recipes

Test your Chef cookbooks nicely.

This project is heavily inspired by RSpec-puppet.

## Installation

```
gem install rspec-chef
```

## Example groups

### Recipes

Follow this structure to organize your recipes:

```
library
  |
  +-- cookbooks
  |
  +-- specs
        |
        +-- recipes
              |
              +-- <recipe_name>_spec.rb
```

Or force the example group into the spec:

```ruby

describe 'cookbook::recipe', :type => :recipe do
  ...
end
```

## Matchers

All of the standard RSpec matchers are available for you to use when testing Chef recipes.

*Checking if a recipe contains a resource*

Use the matcher `contain_<resource_type>` matcher:

```ruby
  it { should contain_remote_file }
```

It can take the name of the resource as a parameter:

```ruby
  it { should contain_remote_file('/etc/chef/dna.json') }
```

It can take the parameters that the resource takes:

```ruby
  it { should contain_remote_file('/etc/chef/dna.json', {:action => :nothing}) }
```

Use the chain `with_<attr_name>` to test the further attributes that the resource gets:

```ruby
  it { should contain_remote_file('/etc/chef/dna.json').with_source('dna.json.erb') }
```

## Settings

*Cookbooks path*

The path to the cookbooks can be specified using `let` for each group:

```ruby
describe 'foo::bar' do
  let(:cookbook_path) { File.expand_path('../cookbooks', __FILE__) }
end
```

Or it can be set as a global RSpec setting:

```ruby
RSpec.configure do |c|
  c.cookbook_path File.expand_path('../cookbooks', __FILE__)
end
```

*JSON attributes*

Each recipe includes a node. This node can be feeded with a hash using `let` in the description group:

```ruby
describe 'foo::bar' do
  let(:json_attributes) { {:foo => :bar} }
end
```

With a file in our file system:

```ruby
describe 'foo::bar' do
  let(:json_attributes) { '/etc/chef/dna.json' }
end
```

Or with plain JSON:

```ruby
describe 'foo::bar' do
  let(:json_attributes) { '{"foo": "bar"}' }
end
```

The JSON attributes can alson be set as a global RSpec setting:

```ruby
RSpec.configure do |c|
  c.json_attributes {}
end
```
