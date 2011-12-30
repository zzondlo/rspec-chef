require File.expand_path('../../spec_helper', File.dirname(__FILE__))


class MockResource
  attr_reader :params

  def initialize(params = {}, attributes = {})
    @params = params
    @attributes = attributes
  end

  def method_missing(method, *attrs)
    @attributes[method]
  end
end

class MockRecipe
  def initialize(resources = {})
    @resources = resources
  end

  def resources(name)
    @resources[name]
  end
end

describe RSpec::Chef::Matchers::ContainResource do

  context "validating recipes" do
    it "matches a resource with a name" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new)
      matcher = described_class.new(:contain_remote_file, :foo)

      matcher.matches?(recipe).should be_true
    end

    it "matches a resource without a name" do
      recipe = MockRecipe.new('remote_file' => MockResource.new)
      matcher = described_class.new(:contain_remote_file)

      matcher.matches?(recipe).should be_true
    end

    it "matches a resource with parameters" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new(:bar => :baz))
      matcher = described_class.new(:contain_remote_file, :foo, {:bar => :baz})

      matcher.matches?(recipe).should be_true
    end

    it "doesn't match a resource which params don't match" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new(:bar => :baz))
      matcher = described_class.new(:contain_remote_file, :foo, {:bar => :koi})

      matcher.matches?(recipe).should be_false
    end

    it "matches a resource with expected attributes" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new({}, {:version => '0.1'}))
      matcher = described_class.new(:contain_remote_file, :foo).with(:version, '0.1')

      matcher.matches?(recipe).should be_true
    end

    it "doesn't match a resource which expected attributes don't match" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new({}, {:version => '0.1'}))
      matcher = described_class.new(:contain_remote_file, :foo).with(:version, '1.1')

      matcher.matches?(recipe).should be_false
    end

    it "matches a resource without unexpected attributes" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new)
      matcher = described_class.new(:contain_remote_file, :foo).without(:version)

      matcher.matches?(recipe).should be_true
    end

    it "mathes a resource without several unexpected attributes" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new)
      matcher = described_class.new(:contain_remote_file, :foo).without(:version, :notif)

      matcher.matches?(recipe).should be_true
    end

    it "doesn't match a resource with unexpected attributes" do
      recipe = MockRecipe.new('remote_file[foo]' => MockResource.new({}, {:version => '0.1'}))
      matcher = described_class.new(:contain_remote_file, :foo).without(:version)

      matcher.matches?(recipe).should be_false
    end
  end

  it "includes a description" do
    matcher = described_class.new(:contain_remote_file, :foo)

    matcher.description.should == %q{include Resource[remote_file @name="foo"]}
  end

  it "includes a message for should failure" do
    matcher = described_class.new(:contain_remote_file, :foo)
    matcher.failure_message_for_should.should == %q{expected that the recipe would include Resource[remote_file @name="foo"]}
  end
end
