require 'test/unit'
require 'bocadillo'
require 'yaml'

class BocadilloTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/arrays.yml'
    @fixtures = YAML.load_file(@fixture_file)
  end

  def test_encode
    # It should return the string unaltered if the array has a single element
    assert_equal 'albero',
      Bocadillo.encode(['albero'], '(', '|', ')')
  end

  def test_encode_no_common_radix
    # Strings without a common radix
    assert_equal 'a|b|c',
      Bocadillo.encode(['a', 'b', 'c'], '(', '|', ')')
    assert_equal 'albero|fiore',
      Bocadillo.encode(@fixtures['ALBERO_FIORE'], '(', '|', ')')
  end

  def test_encode_common_radix
    # Strings with a common radix
    assert_equal 'alb(a|er(go|o|to))',
      Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'], '(', '|', ')')
    assert_equal 'pesc(a(|tore)|h(eria|iera))',
      Bocadillo.encode(@fixtures['PESCA_TORE_H_ERIA_IERA'], '(', '|', ')')
    assert_equal 'mar(e|i(a|na(|io)|o))',
      Bocadillo.encode(@fixtures['MARE_INA_IO_IA'], '(', '|', ')')
  end

  def test_encode_mixed_strings
    # Mixed strings
    assert_equal 'alb(a|er(go|o|to))|pesc(a(|tore)|h(eria|iera))',
      Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'].clone.concat(@fixtures['PESCA_TORE_H_ERIA_IERA']), '(', '|', ')')
  end

  def test_encode_scrambled_order
    # Order of input doesn't matter
    assert_equal Bocadillo.encode(@fixtures['ALBERO_FIORE'].reverse, '(', '|', ')'),
      Bocadillo.encode(@fixtures['ALBERO_FIORE'], '(', '|', ')')
    assert_equal Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'].reverse, '(', '|', ')'),
      Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'], '(', '|', ')')
  end

  def test_encode_isin
    @fixture_file = 'test/fixtures/parser.yml'
    @fixtures = YAML.load_file(@fixture_file)

    # A real life example
    assert_equal @fixtures['ISIN']['string'], Bocadillo.encode(@fixtures['ISIN']['array'], '(', '|', ')')
  end

  def test_decode
    # It should return the string unaltered if the array has a single element
    assert_equal ['albero'],
      Bocadillo.decode('albero', '(', '|', ')')
  end

  def test_decode_no_common_radix
    # Strings without a common radix
    assert_equal ['a', 'b', 'c'],
      Bocadillo.decode('a|b|c', '(', '|', ')')
    assert_equal @fixtures['ALBERO_FIORE'],
      Bocadillo.decode('albero|fiore', '(', '|', ')')
  end

  def test_decode_common_radix
    # Strings with a common radix
    assert_equal @fixtures['ALB_A_ER_GO_O_TO'],
      Bocadillo.decode('alb(a|er(go|o|to))', '(', '|', ')')
    assert_equal @fixtures['PESCA_TORE_H_ERIA_IERA'],
      Bocadillo.decode('pesc(a(|tore)|h(eria|iera))', '(', '|', ')')
    assert_equal @fixtures['MARE_INA_IO_IA'],
      Bocadillo.decode('mar(e|i(a|na(|io)|o))', '(', '|', ')')
  end

  def test_decode_mixed_strings
    # Mixed strings
    assert_equal @fixtures['ALB_A_ER_GO_O_TO'].clone.concat(@fixtures['PESCA_TORE_H_ERIA_IERA']),
      Bocadillo.decode('alb(a|er(go|o|to))|pesc(a(|tore)|h(eria|iera))', '(', '|', ')')
  end

  def test_decode_scrambled_order
    # Order of input doesn't matter
    assert_equal Bocadillo.decode(@fixtures['ALBERO_FIORE'], '(', '|', ')'),
      Bocadillo.decode(@fixtures['ALBERO_FIORE'].reverse, '(', '|', ')')
    assert_equal Bocadillo.decode(@fixtures['ALB_A_ER_GO_O_TO'], '(', '|', ')'),
      Bocadillo.decode(@fixtures['ALB_A_ER_GO_O_TO'].reverse, '(', '|', ')')
  end

  def test_decode_isin
    @fixture_file = 'test/fixtures/parser.yml'
    @fixtures = YAML.load_file(@fixture_file)

    # A real life example
    assert_equal @fixtures['ISIN']['string'],
      Bocadillo.decode(@fixtures['ISIN']['array'], '(', '|', ')')
  end
end
