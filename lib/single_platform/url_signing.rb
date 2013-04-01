class SinglePlatform::UrlSigning
  require 'rubygems'
  require 'openssl'
  require 'base64'

  # from SinglePlatform sample ruby library
  def self.make_signature(uri_path, params, client_id, secret)
    padding_factor = (4 - secret.length % 4) % 4
    secret += "=" * padding_factor
    secret = secret.gsub(/[-_]/, {"-" => "+", "_" => "/"})
    binary_key = Base64.decode64(secret)

    params.update({"client" => client_id})
    path = uri_path + "?" + params.collect{|k,v| "#{k}=#{v}"}.inject{|initial,cur| initial + "&" + cur}

    #digest = HMAC::SHA1.new(binary_key).update(path).digest
    digest = OpenSSL::HMAC.digest('sha1',binary_key, path)
    digest = Base64.encode64(digest).gsub(/[+\/]/, {"+" => "-", "/" => "_"}).delete("=")
    #return "#{path}&sig=#{digest}"
    digest.delete("\n")
  end

end