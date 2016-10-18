##
# Instances of this class represent the current state of the map, i.e., the
# game board.
class Vindinium::Client::Map
  def initialize(map: [])
    @tiles = map
  end

  ##
  # Returns the size of the map in terms of the number of horizontal or
  # vertical tiles (the map is always square).
  def size
    Math.sqrt(@tiles.length).to_i
  end

  ##
  # Returns the string representation of the map.
  def to_s(pretty_print: false)
    @tiles.each_with_index do |t, i|
      print "\n" if pretty_print && i % Math.sqrt(@tiles.length).to_i == 0
      puts t.to_s
    end
  end

  ##
  # Accesses the tile at the given position.
  #
  # Parameters are +row+ and +col+, denoting the row and column number,
  # respectively. Rows and columns are counted starting from 0.
  #
  #   map[0,0]   # => The first tile
  def [](row, col)
    @tiles[size * row + col]
  end

  ##
  # Parses the string representation of the map and returns a new Map object
  # from it.
  #
  # The +string+ parameter contains the actual map string, +size+ the number
  # of horizontal and vertical tiles. Vindinium maps are always square.
  def self.parse(string, size)
    map = []

    (0..2*size**2-1).step(2) do |i|
      map << Vindinium::Client::Tile.parse(string[i..i+1])
    end

    Vindinium::Client::Map.new map: map
  end
end
