require 'test/unit'
require 'bocadillo'
require 'yaml'

Parser = Bocadillo::Parser

class ParserTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/parser.yml'
    @fixtures = YAML.load_file(@fixture_file)
  end

  def test_incompatible_words
    assert_equal ['cane', 'gatto'],
      Parser.parse('cane|gatto', '(', '|', ')')
    assert_equal ['cane', 'gatto', 'unicorno'],
      Parser.parse('cane|gatto|unicorno', '(', '|', ')')
  end

  def test_common_prefixes
    assert_equal ['alba', 'alga'],
      Parser.parse('al(ba|ga)', '(', '|', ')')
    assert_equal ['alba', 'albergo', 'albero', 'alberto'],
      Parser.parse('alb(a|er(go|o|to))', '(', '|', ')')
    assert_equal ['alba', 'albergatore', 'albergo', 'albero', 'alberto'],
      Parser.parse('alb(a|er(g(atore|o)|o|to))', '(', '|', ')')
  end

  def test_panflute_strings_ascending
    assert_equal ['certa', 'certamente'],
      Parser.parse('certa(|mente)', '(', '|', ')')
  end

  def test_isin
    assert_equal  @fixtures['ISIN']['array'],
      Parser.parse(@fixtures['ISIN']['string'], '(', '|', ')')
  end
end
