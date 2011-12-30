require File.expand_path('../spec_helper', File.dirname(__FILE__))

class ChefJSONSupport
  include RSpec::Chef::JSONSupport
end

describe ChefJSONSupport do
  require 'tempfile'

  it "returns a hash if the parameter is a hash" do
    subject.json({:foo => :bar}).should == {:foo => :bar}
  end

  it "returns the content of a dna file if the parameter is a file path" do
    path = Tempfile.open('dna.json') do |file|
      file.write('{"foo": "bar"}')
      file.path
    end

    subject.json(path).should == {'foo' => 'bar'}
  end

  it "returns and empty hash if it cannot parse the file" do
    path = Tempfile.open('dna.json') do |file|
      file.write('foo: bar')
      file.path
    end

    subject.json(path).should == {}
  end

  it "returns the json parsed when the parameter is a json string" do
    subject.json('{"foo": "bar"}').should == {'foo' => 'bar'}
  end

  it "returns an empty hash is it cannot parse the json" do
    subject.json('foo: bar').should == {}
  end
end
