require 'minitest/autorun'

class MineTileTest < MiniTest::Unit::TestCase
  def test_that_it_parses_the_owner
    assert_equal false, Vindinium::Client::Tile.parse('$-').owned?
    assert_equal true, Vindinium::Client::Tile.parse('$1').owned?
    assert_equal '1', Vindinium::Client::Tile.parse('$1').owner
  end
end
