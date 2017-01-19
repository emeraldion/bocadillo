class Bocadillo::Args
  def self.get
    i = -1
    str = ARGV[i+=1]
    separator = ARGV[i+=1] || ','
    preamble = ARGV[i+=1] || '('
    delimiter = ARGV[i+=1] || '|'
    terminator = ARGV[i+=1] || ')'

  	{
  		:string => str,
  		:separator => separator,
  		:preamble => preamble,
  		:delimiter => delimiter,
  		:terminator => terminator
  	}
  end
end
