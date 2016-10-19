##
# Locates a hero on the map.
class Vindinium::Client::HeroTile < Vindinium::Client::Tile

  ##
  # The hero's ID (number)
  attr_reader :number

  ##
  # The actual hero object
  attr_accessor :hero

  def initialize(number)
    super :hero
    @number = number
  end
end
