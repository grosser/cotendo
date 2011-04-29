require File.expand_path('spec/spec_helper')

describe Cotendo do
  it "has a VERSION" do
    Cotendo::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end
