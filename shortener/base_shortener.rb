require "stringio"
require "./shortener/shortener"

class BaseShortener
  ALPHABET = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

  def self.shorten(id, url)
    short = StringIO.new

    loop do
      short << ALPHABET[id % ALPHABET.length]
      id /= ALPHABET.length
      break if id.zero?
    end

    short.string
  end
end
