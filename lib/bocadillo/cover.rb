class Bocadillo::Cover
  def self.cover(arr = [], x0 = 0, y = 0, l = nil)
    l = arr.length if l.nil?
    # Check bad input
    if x0 >= l
      # Error: past assigned slice
      return false
    end
    if not arr[x0]
      # Error: past array length
      return false;
    end

    if y > arr[x0].length - 1
      if x0 === l - 1
        # Termination of rightmost string
        return [nil]
      end
      # The string at x0 was only as long as y0, so call on the next item
      return [nil].concat(self.cover(arr, x0 + 1, y, l))
    end

    # Initialize non-trivial return structure
    u = {
      'l' => arr[x0][y],
      'c' => []
    }
    r = [u]

    # Spread in width until we find either the end, or a different char
    x = x0
    m = false
    loop do
      if x < l and arr[x0][y] === arr[x][y]
        m = true 
        x += 1
      end
      break if m
    end

    # If we haven't covered the full length of the assigned slice, launch
    # on the pair (x + 1, y0) with the original length l.
    if x < l
      r.concat(self.cover(arr, x, y, l))
    end

    # Launch on the tail of the string at s[x0] from the position y
    u['c'].concat(self.cover(arr, x0, y + 1, x))

    r
  end
end
