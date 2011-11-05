require "digest/sha1"

class HashKey
  def initialize(params)
    @params = params
  end

  def compute
    all_params = @params.map do |key, value|
      "#{key}=#{value}"
    end.join("&")
    Digest::SHA1.hexdigest all_params
  end
end
