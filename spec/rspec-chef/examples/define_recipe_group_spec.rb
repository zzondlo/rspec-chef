require 'spec_helper'

describe "foo", :type => :recipe do
  let(:cookbook_path) { COOKBOOKS }

  it { subject.should contain_remote_file('/tmp/foo') }
end

describe "foo::install", :type => :recipe do
  let(:cookbook_path) { COOKBOOKS }
  let(:json_attributes) { {:path => '/tmp/foo'} }

  it { subject.should contain_remote_file('/tmp/foo') }
end
