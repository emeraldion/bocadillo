require 'test/unit'
require 'bocadillo'
require 'yaml'

Serializer = Bocadillo::Serializer

class SerializerTest < Test::Unit::TestCase
  def setup
    @fixture_file = 'test/fixtures/cover.yml'
    @fixtures = YAML.load_file(@fixture_file)

    @trees = {}
    @fixtures.each do |k, v|
      @trees[k] = {
        'l' => '',
        'c' => v['tree']
      }
    end
  end

  def test_serialize
    assert_equal 'a', Serializer.serialize(@trees['A'], '(', '|', ')')
    assert_equal 'a', Serializer.serialize(@trees['A'], '*', '&', '^')
    assert_equal 'a', Serializer.serialize(@trees['A'], '-', '_', '`')

    assert_equal 'a|b', Serializer.serialize(@trees['A_B'], '(', '|', ')')
    assert_equal 'a&b', Serializer.serialize(@trees['A_B'], '*', '&', '^')
    assert_equal 'a_b', Serializer.serialize(@trees['A_B'], '-', '_', '`')

    assert_equal 'a(|b)', Serializer.serialize(@trees['A_AB'], '(', '|', ')')
    assert_equal 'a*&b^', Serializer.serialize(@trees['A_AB'], '*', '&', '^')
    assert_equal 'a-_b`', Serializer.serialize(@trees['A_AB'], '-', '_', '`')

    assert_equal 'aria(nna|)', Serializer.serialize(@trees['ARIA_ANNA'], '(', '|', ')')
    assert_equal 'aria*nna&^', Serializer.serialize(@trees['ARIA_ANNA'], '*', '&', '^')
    assert_equal 'aria[nna+]', Serializer.serialize(@trees['ARIA_ANNA'], '[', '+', ']')

    assert_equal 'alb(a|er(go|o|to))', Serializer.serialize(@trees['ALB_A_ER_GO_O_TO'], '(', '|', ')')
    assert_equal 'alb*a&er*go&o&to^^', Serializer.serialize(@trees['ALB_A_ER_GO_O_TO'], '*', '&', '^')
    assert_equal 'alb~a*er~go*o*to==', Serializer.serialize(@trees['ALB_A_ER_GO_O_TO'], '~', '*', '=')
    assert_equal 'alb[a+er[go+o+to]]', Serializer.serialize(@trees['ALB_A_ER_GO_O_TO'], '[', '+', ']')

    assert_equal 'viale(|tto)', Serializer.serialize(@trees['VIALE_ETTO'], '(', '|', ')')
    assert_equal 'viale[+tto]', Serializer.serialize(@trees['VIALE_ETTO'], '[', '+', ']')
    assert_equal 'viale~*tto=', Serializer.serialize(@trees['VIALE_ETTO'], '~', '*', '=')
  end
end
