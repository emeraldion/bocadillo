class Bocadillo::Parser
  def self.parse(str, preamble, divider, terminator)
    arr = []
    i = 0
    j = 0
    k = 0
    
    while i < str.length do
      if str[i, str.length].index(preamble) === 0 # (
        t = arr[j + k]
        arr.insert(j + k + 1, t)
        i += preamble.length
      elsif str[i, str.length].index(divider) === 0 # |
        k += 1
        t = arr[j + k]
        arr.insert(j + k, t)
        i += divider.length
      elsif str[i, str.length].index(terminator) === 0 # )
        arr.slice!(j + k + 1, 1)
        j += k
        k = 0
        i += terminator.length
      else
        # trivial case, just keep appending to i+j-th string
        arr[j + k] = (arr[j + k]||'') + str[i]
        i += 1
      end
    end
    arr
  end
end
