class Vindinium::Client::Tile

  ##
  # A list of all known tile types, with their respective string patterns.
  TYPES = { '  '        => :way,
            '##'        => :impassable,
            '[]'        => :tavern,
            /\@[1-4]/   => :hero,
            /\$[-1-4]/  => :mine }

  ##
  # The type of the tile
  attr_reader :type

  def initialize(type)
    @type = type
  end

  ##
  # Creates the appropriate tile type from a string.
  def self.parse(string)
    Vindinium::Client::Tile.new TYPES.find { |k,v| k === string }.last
  end

  ##
  # Returns true if the tile is passable
  def passable?
    return type != :impassable
  end
end
