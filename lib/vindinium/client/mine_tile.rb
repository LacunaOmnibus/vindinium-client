##
# Represents a mine on the tableau.
class Vindinium::Client::MineTile < Vindinium::Client::Tile

  ##
  # The current owner of the mine.
  attr_reader :owner

  def initialize(owner)
    super :mine
    @owner = owner
  end

  def owned?
    @owner != '-'
  end
end
