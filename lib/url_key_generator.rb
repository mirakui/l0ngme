require 'active_support/core_ext'
class UrlKeyGenerator
  def self.longen(source_url, length, candidate=0)
    key = source_url.gsub(/[^a-z0-9]/i,'')
    left_length = length
    if key.length > left_length
      _longen_short(key, length, candidate)
    else
      _longen_long(key, length, candidate)
    end
  end

  private
  def self.longen_short(key, length, candidate)
    left_length = length
    key[-(left_length+candidate), left_length]
  end

  def self.longen_long(key, length, candidate)
    left_length = length
    spacers = Array.new(key.length - 1) {''}
    (left_length - key.length).times do |i|
      spacers[i % spacers.length] += '_'
    end
    srand(candidate)
    spacers.shuffle!
    spacers << ''
    result = ''
    key.split(//).each_with_index do |c, i|
      result += c + spacers[i]
    end
    result
  end
end

