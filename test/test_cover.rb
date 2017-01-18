require 'test/unit'
require 'bocadillo'
require 'yaml'

Cover = Bocadillo::Cover

class CoverTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/cover.yml'
    @fixtures = YAML.load_file(@fixture_file)
  end

  def test_cover_single
    assert_equal @fixtures['A']['tree'],
      Cover.cover(@fixtures['A']['array'])
  end

  def test_cover_pair
    assert_equal @fixtures['A_B']['tree'],
      Cover.cover(@fixtures['A_B']['array'])
  end
end