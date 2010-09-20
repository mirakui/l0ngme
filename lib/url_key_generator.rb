class UrlKeyGenerator
  def self.generate(src_url, length, candidate=0)
    src_key = src_url.gsub(/[^a-z0-9]/i,'')
    left_length = length
    if src_key.length > left_length
      generate_key_short(src_key, length, candidate)
    else
      generate_key_long(src_key, length, candidate)
    end
  end

  private
  def self.generate_key_short(src_key, length, candidate)
    left_length = length
    src_key[-(left_length+candidate), left_length]
  end

  def self.generate_key_long(src_key, length, candidate)
    left_length = length
    spacers = Array.new(src_key.length - 1) {''}
    (left_length - src_key.length).times do |i|
      spacers[i % spacers.length] += '_'
    end
    srand(candidate)
    spacers.shuffle!
    spacers << ''
    result = ''
    src_key.split(//).each_with_index do |c, i|
      result += c + spacers[i]
    end
    result
  end
end

