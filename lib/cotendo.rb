require 'savon'

class Cotendo
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip
  WSDL = "https://api.cotendo.net/cws?wsdl"
  NAMESPACE = 'http://api.cotendo.net/'

  def initialize(options)
    @user = options[:user]
    @password = options[:password]
  end

  def flush(cname, expressions, options = {})
    expressions = [*expressions]
    request(:do_flush,
      :cname => cname,
      :flush_expression => expressions.join("\n"),
      :flush_type => options[:flush_type] || 'hard'
    )
  end

  def client
    @client = begin
      client = Savon::Client.new do
        wsdl.document = WSDL
      end
      client.wsdl.request.auth.basic @user, @password
      client
    end
  end

  def request(method, options)
    response = client.request(api_namespaced(method)) do |r|
      r.namespaces['xmlns:api'] = NAMESPACE
      r.namespaces['xmlns:wsdl'] = WSDL+'&ver=1.0'
      r.body = options
    end
    response.to_hash
  end

  def api_namespaced(method)
    "api:#{method.to_s.gsub(/_./){|x| x.slice(1,1).upcase }}"
  end
end
