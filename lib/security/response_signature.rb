require "digest/sha1"

class ResponseSignature
  def initialize(api_key, response)
    @response_signature = Digest::SHA1.hexdigest "#{response}#{api_key}"
  end

  def valid?(signature)
    @response_signature == signature
  end
end
