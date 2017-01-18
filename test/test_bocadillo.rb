require 'test/unit'
require 'bocadillo'

class BocadilloTest < Test::Unit::TestCase
  def test_encode
    assert_equal "alb(a|ero)",
      Bocadillo.encode(["alba", "albero"], '(', '|', ')')
  end

  def test_decode
    assert_equal ["alba", "albero"],
      Bocadillo.decode("alb(a|ero)", '(', '|', ')')
  end
end