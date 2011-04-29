require 'savon'

class Cotendo
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip

  def initialize(options)
    @user = CGI.escape(options[:user])
    @password = CGI.escape(options[:password])
    @wsdl = "https://api.cotendo.net/cws?wsdl&ver=1.0"
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
        wsdl.document = @wsdl
      end
#      client.request.basic_auth @user, @password
      client
    end
  end

  def request(method, options)
    response = client.request(method) do |r|
      r.body = options
    end
    response.to_hash
  end
end
