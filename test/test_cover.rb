require 'test/unit'
require 'bocadillo'
require 'yaml'

Cover = Bocadillo::Cover

class CoverTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/cover.yml'
    @fixtures = YAML.load_file(@fixture_file)
  end

  def test_bad_input
    assert !Cover.cover(['a'], 1)
    assert !Cover.cover(['a', 'b'], 2)
    assert !Cover.cover(['a', 'b', 'd'], 3)

    assert !Cover.cover(['a'], 1, 0, 2)
    assert !Cover.cover(['a', 'b'], 2, 0, 3)
    assert !Cover.cover(['a', 'b', 'd'], 3, 0, 4)
  end

  def test_cover_single
    assert_equal @fixtures['A']['tree'],
      Cover.cover(@fixtures['A']['array'])
  end

  def test_cover_pair
    puts @fixtures['A_B']['array'].to_s
    assert_equal @fixtures['A_B']['tree'],
      Cover.cover(@fixtures['A_B']['array'])
  end

  def test_cover_substring
    puts @fixtures['ARIA_ANNA']['array'].to_s
    assert_equal @fixtures['ARIA_ANNA']['tree'],
      Cover.cover(@fixtures['ARIA_ANNA']['array'])
  end

  def test_cover_stemmed
    puts @fixtures['ALB_A_ER_GO_O_TO']['array'].to_s
    assert_equal @fixtures['ALB_A_ER_GO_O_TO']['tree'],
      Cover.cover(@fixtures['ALB_A_ER_GO_O_TO']['array'])
  end
end