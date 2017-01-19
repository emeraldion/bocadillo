require 'test/unit'
require 'bocadillo'
require 'yaml'

Parser = Bocadillo::Parser

class IdempotenceTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/arrays.yml'
    @fixtures = YAML.load_file(@fixture_file)
  end

  def test_single_element
    # It should return the string unaltered if the array has a single element
    assert_equal Parser.parse(Bocadillo.encode(['albero'], '(', '|', ')'), '(', '|', ')'), ['albero']
  end

  def test_no_common_radix
    # Strings without a common radix
    assert_equal Parser.parse(Bocadillo.encode(['a', 'b', 'c'], '(', '|', ')'), '(', '|', ')'), ['a', 'b', 'c']
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ALBERO_FIORE'], '(', '|', ')'), '(', '|', ')'),
      @fixtures['ALBERO_FIORE'].sort
  end

  def test_common_radix
    # Strings with a common radix
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'], '(', '|', ')'), '(', '|', ')'),
      @fixtures['ALB_A_ER_GO_O_TO'].sort
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['PESCA_TORE_H_ERIA_IERA'], '(', '|', ')'), '(', '|', ')'),
      @fixtures['PESCA_TORE_H_ERIA_IERA'].sort
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['MARE_INA_IO_IA'], '(', '|', ')'), '(', '|', ')'),
      @fixtures['MARE_INA_IO_IA'].sort
  end

  def test_mixed_strings
    # Mixed strings
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO']
      .clone.concat(@fixtures['PESCA_TORE_H_ERIA_IERA']), '(', '|', ')'), '(', '|', ')'),
        @fixtures['ALB_A_ER_GO_O_TO'].clone.concat(@fixtures['PESCA_TORE_H_ERIA_IERA']).sort
  end

  def test_scrambled_strings
    puts @fixtures['ALBERO_FIORE'].to_s
    # Order of input doesn't matter
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ALBERO_FIORE'], '(', '|', ')'), '(', '|', ')'),
              Parser.parse(Bocadillo.encode(@fixtures['ALBERO_FIORE'].reverse, '(', '|', ')'), '(', '|', ')')
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'], '(', '|', ')'), '(', '|', ')'),
              Parser.parse(Bocadillo.encode(@fixtures['ALB_A_ER_GO_O_TO'].reverse, '(', '|', ')'), '(', '|', ')')
  end

  def test_isin
    # A real life example
    assert_equal Parser.parse(Bocadillo.encode(@fixtures['ISIN_1'], '(', '|', ')'), '(', '|', ')'),
      @fixtures['ISIN_1'].sort
  end
end
