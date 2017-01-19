class Bocadillo
  def self.encode(arr, preamble = '(', divider = '|', terminator = ')')
    arr.sort!
    Serializer.serialize({
      'l' => '',
      'c' => Cover.cover(arr)
    }, preamble, divider, terminator)
  end

  def self.decode(str, preamble = '(', divider = '|', terminator = ')')
    Parser.parse(str, preamble, divider, terminator)
  end
end

require 'bocadillo/args'
require 'bocadillo/cover'
require 'bocadillo/parser'
require 'bocadillo/serializer'
require 'bocadillo/usage'