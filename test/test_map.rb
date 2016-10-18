require 'minitest/autorun'

class TestMap < MiniTest::Unit::TestCase
  def setup
    @size = 18
    @map_string = \
      '##############        ##############' \
      '##############        ##############' \
      '################    ################' \
      '##############$4    $4##############' \
      '##############  @4    ##############' \
      '##########  @1##    ##    ##########' \
      '##########  []        []  ##########' \
      '########        ####        ########' \
      '############  $4####$4  ############' \
      '############  $4####$4  ############' \
      '########        ####        ########' \
      '##########  []        []  ##########' \
      '##########  @2##    ##@3  ##########' \
      '##############        ##############' \
      '##############$-    $-##############' \
      '################    ################' \
      '##############        ##############' \
      '##############        ##############'
  end

  def test_that_it_parses
    map = Vindinium::Client::Map.parse @map_string, @size
    assert_equal 18, map.size
  end

  def test_that_it_accesses_the_map
    map = Vindinium::Client::Map.parse @map_string, @size

    assert_equal :impassable, map[0,0].type
    assert_equal :mine, map[3,7].type
    assert_equal :hero, map[12,6].type
  end
end
