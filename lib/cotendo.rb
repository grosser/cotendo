require 'savon'

class Cotendo
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip
  WSDL = "https://api.cotendo.net/cws?wsdl"
  NAMESPACE = 'http://api.cotendo.net/'
  ENVIRONMENTS = { :staging => 0, :production => 1 }

  def initialize(options)
    @user = options[:user] or raise("missing :user")
    @password = options[:password] or raise("missing :password")
  end

  def flush(cname, expressions, options = {})
    expressions = [*expressions]
    request(:do_flush,
      'api:cname' => cname,
      'api:flushExpression' => expressions.join("\n"),
      'api:flushType' => options[:flush_type] || 'hard'
    )
  end
  
  def dns_get_conf(domain_name, options = {})
    environment = options[:environment] || :production
    environment = ENVIRONMENTS[environment] if ENVIRONMENTS[environment]    
    request('dns_get_conf',
      'api:domainName' => domain_name,
      'api:environment' => environment
    )
  end

  def client
    @client ||= begin
      Savon::Client.new do |wsdl, http, wsse|
        wsdl.document = WSDL
        wsdl.endpoint = WSDL + '&ver=1.0'
        http.auth.basic @user, @password
      end
    end
  end

  def request(method, options)
    response = client.request(api_namespaced(method)) do |soap|
      soap.namespaces['xmlns:api'] = NAMESPACE
      soap.body = options
    end
    response.to_hash
  end

  def api_namespaced(method)
    if method.is_a? Symbol
      "api:#{method.to_s.gsub(/_./){|x| x.slice(1,1).upcase }}"
    else
      "api:#{method}"
    end
  end
end
