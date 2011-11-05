require "digest/sha1"

class HashKey
  def initialize(params)
    @params = params
  end

  def compute
    Digest::SHA1.hexdigest join_all_params
  end

  private

  def join_all_params
    @params.sort.map do |key, value|
      "#{key}=#{value}"
    end.join("&")
  end
end
