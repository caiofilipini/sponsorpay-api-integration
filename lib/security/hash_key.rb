require "digest/sha1"

class HashKey
  JOIN_CHAR = "&"

  def initialize(api_key, params)
    @api_key = api_key
    @params = keys_to_sym(params)
  end

  def compute
    Digest::SHA1.hexdigest join_all_params
  end

  private

  def join_all_params
    joined_params = @params.sort.map do |key, value|
      "#{key}=#{value}"
    end.join(JOIN_CHAR)
    "#{joined_params}#{JOIN_CHAR}#{@api_key}"
  end

  def keys_to_sym(hash)
    new_hash = Hash.new
    hash.each do |key, value|
      new_hash[key.to_sym] = value
    end
    new_hash
  end
end
