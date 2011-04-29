require File.expand_path('spec/spec_helper')

describe Cotendo do
  let(:config){ YAML.load_file('spec/config.yml') }
  let(:client){ Cotendo.new(config) }

  it "has a VERSION" do
    Cotendo::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  describe :flush do
    it "can do it" do
      client.flush(config[:cname], '/foo')
    end
  end
end
