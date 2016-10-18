require 'minitest/autorun'

class HeroTileTest < MiniTest::Unit::TestCase
  def test_that_it_parses_the_number
    assert_equal '1', Vindinium::Client::Tile.parse('@1').number
    assert_equal '4', Vindinium::Client::Tile.parse('@4').number
  end
end

