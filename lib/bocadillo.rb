class Bocadillo
  def self.encode(words, preamble = '(', divider = '|', terminator = ')')
    Serializer.serialize({
      'l' => '',
      'c' => Cover.cover(words.sort)
    }, preamble, divider, terminator)
  end

  def self.decode(encoded_string, preamble = '(', divider = '|', terminator = ')')
    Parser.parse(encoded_string, preamble, divider, terminator)
  end
end

require 'bocadillo/args'
require 'bocadillo/cover'
require 'bocadillo/parser'
require 'bocadillo/serializer'
require 'bocadillo/usage'