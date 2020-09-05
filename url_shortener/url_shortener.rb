# URL SHORTENER
require 'securerandom'

class Shortener
  # Hex -> Main url
  # 01ef -> main_url
  @@url_map = {}

  MAX_TRIES = 10
  @@key_length = 4

  def self.short(url)
    approaches = 0
    random_string = SecureRandom.hex(@@key_length)
    loop do
      approaches += 1
      if approaches >= MAX_TRIES
        @@key_length += 1
        random_string = SecureRandom.hex(@@key_length)
        approaches = 0
      elsif @@url_map.has_key?(random_string)
        random_string = SecureRandom.hex(4)
      else
        break
      end
    end
    @@url_map[random_string] = url
    random_string
  end

  def self.redirect(short)
    @@url_map[short]
  end
end

# shortener = Shortener.short(url_to_short)
# puts "Short: #{shortener}"
# puts "Redirect: #{Shortener.redirect(shortener)}"
