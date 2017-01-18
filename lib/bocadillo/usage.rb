class Bocadillo::Usage
  def self.usage
  	puts <<END
Usage:
	bocadillo <string> [<separator> [<child preamble> [<child separator> [<child terminator>]]]]

Examples:
	bocadillo 'alba,albero,albino'
	# => alb(a|ero|ino)

	bocadillo 'alba:albero:albino' ':' '[' ',' ']'
	# => alb[a,ero,ino]

END
  end
end
