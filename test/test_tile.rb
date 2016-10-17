require 'minitest/autorun'

class TileTest < MiniTest::Unit::TestCase
  def test_that_it_parses
    assert_equal :way, Vindinium::Client::Tile.parse('  ').type
    assert_equal :impassable, Vindinium::Client::Tile.parse('##').type
    assert_equal :tavern, Vindinium::Client::Tile.parse('[]').type
    assert_equal :hero, Vindinium::Client::Tile.parse('@1').type
    assert_equal :hero, Vindinium::Client::Tile.parse('@4').type
    assert_equal :mine, Vindinium::Client::Tile.parse('$3').type
    assert_equal :mine, Vindinium::Client::Tile.parse('$-').type
  end
end
