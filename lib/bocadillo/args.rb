class Bocadillo::Args
  def self.parse
    i = 1
    str = ARGV[i++]
    s = ARGV[i++] || ','
    p = ARGV[i++] || '('
    d = ARGV[i++] || '|'
    t = ARGV[i++] || ')'

  	{
  		:string => str,
  		:separator => separator,
  		:preamble => preamble
  		:delimiter => delimiter,
  		:terminator => terminator
  	}
  end
end
