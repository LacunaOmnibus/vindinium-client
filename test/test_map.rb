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

  def test_that_it_retrieves_neighbors
    map = Vindinium::Client::Map.parse @map_string, @size
    tile = map[4,7]
    neighbors = map.neighbors tile

    assert_equal :mine, neighbors[:north].type
    assert_equal :hero, neighbors[:east].type
    assert_equal :impassable, neighbors[:south].type
    assert_equal :impassable, neighbors[:west].type
  end

  def test_that_it_retrieves_neighbors_on_borders
    map = Vindinium::Client::Map.parse @map_string, @size

    neighbors = map.neighbors map[0,7]
    assert_equal nil, neighbors[:north]
    assert_equal :way, neighbors[:east].type
    assert_equal :way, neighbors[:south].type
    assert_equal :impassable, neighbors[:west].type

    neighbors = map.neighbors map[0,0]
    assert_equal nil, neighbors[:north]
    assert_equal :impassable, neighbors[:east].type
    assert_equal :impassable, neighbors[:south].type
    assert_equal nil, neighbors[:west]

    neighbors = map.neighbors map[17,17]
    assert_equal nil, neighbors[:east]
    assert_equal :impassable, neighbors[:north].type
    assert_equal :impassable, neighbors[:west].type
    assert_equal nil, neighbors[:south]
  end
end
