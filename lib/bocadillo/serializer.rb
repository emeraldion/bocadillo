class Bocadillo::Serializer
  def self.serialize(tree, preamble, divider, terminator, nested = false)
    return '' if tree.nil?

    head = [tree['l']]
    if tree['c'].length === 0
      return head
    end

    if tree['c'].length === 1
      tail = [self.serialize(tree['c'][0], preamble, divider, terminator, true)]
    else
      suffixes = tree['c'].map do |suffix|
        Bocadillo::Serializer.serialize(suffix, preamble, divider, terminator, true)
      end
      tail = [suffixes.join(divider)]
      if nested
        tail = [preamble].concat(tail).concat([terminator]);
      end
    end
    return head.concat(tail).join('')
  end
end
