class Vindinium::Client::Tile

  ##
  # A list of all known tile types, with their respective string patterns.
  TYPES = { '  '          => :way,
            '##'          => :impassable,
            '[]'          => :tavern,
            /\@([1-4])/   => :hero,
            /\$([-1-4])/  => :mine }

  ##
  # The type of the tile
  attr_reader :type

  def initialize(type)
    @type = type
  end

  ##
  # Creates the appropriate tile type from a string.
  def self.parse(string)
    tile_type = TYPES.find { |k,v| k === string }.last
    case tile_type
    when :hero
      Vindinium::Client::HeroTile.new $1
    when :mine
      Vindinium::Client::MineTile.new $1
    else
      Vindinium::Client::Tile.new tile_type
    end
  end

  ##
  # Returns true if the tile is passable
  def passable?
    return type != :impassable
  end
end
