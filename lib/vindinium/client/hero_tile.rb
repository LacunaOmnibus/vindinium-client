##
# Represents a hero on the map.
class Vindinium::Client::HeroTile < Vindinium::Client::Tile

  ##
  # The number of the hero
  attr_reader :number

  def initialize(number)
    super :hero
    @number = number
  end
end
