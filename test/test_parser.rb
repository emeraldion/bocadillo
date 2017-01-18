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
    assert_equal Parser.parse('cane|gatto', '(', '|', ')'),
      ['cane', 'gatto']
    assert_equal Parser.parse('cane|gatto|unicorno', '(', '|', ')'),
      ['cane', 'gatto', 'unicorno']
  end

  def test_common_prefixes
    assert_equal Parser.parse('al(ba|ga)', '(', '|', ')'),
      ['alba', 'alga']
    assert_equal Parser.parse('alb(a|er(go|o|to))', '(', '|', ')'),
      ['alba', 'albergo', 'albero', 'alberto']
    assert_equal Parser.parse('alb(a|er(g(atore|o)|o|to))', '(', '|', ')'),
      ['alba', 'albergatore', 'albergo', 'albero', 'alberto']
  end

  def test_panflute_strings_ascending
    assert_equal Parser.parse('certa(|mente)', '(', '|', ')'),
      ['certa', 'certamente']
  end

  def test_isin
    assert_equal Parser.parse(@fixtures['ISIN']['string'], '(', '|', ')'),
      @fixtures['ISIN']['array']
  end
end
