require 'faraday'
require 'faraday_middleware'

class SinglePlatform::Request

  def self.get(path, params={})
    new.get(path, params)
  end

  def get(path, params={})
    client.get do |req|
      req.url path
      req.headers['Accept'] = 'application/json'
      params.each do |key, value|
        req.params[key] = value
      end
      req.params['client'] = SinglePlatform.config.client_id
      req.params['sig'] = signature(path, params)
    end
  end

  protected

  def signature(path, params)
    SinglePlatform::UrlSigning.make_signature(path, params, SinglePlatform.config.client_id, SinglePlatform.config.secret)
  end

  def domain
    "http://api.singleplatform.co"
  end

  def client
    @client ||= Faraday.new domain do |conn|
      conn.use FaradayMiddleware::EncodeJson
      conn.use FaradayMiddleware::ParseJson
      conn.use FaradayMiddleware::Instrumentation
      conn.use Faraday::Response::Logger
      conn.adapter Faraday.default_adapter
    end
  end

end