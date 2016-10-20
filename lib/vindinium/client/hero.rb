##
# An actual hero on the map
class Vindinium::Client::Hero

  ##
  # Initializes the hero with raw data hash retrived from the JSON game state.
  def initialize(properties)
    @properties = properties
  end

  ##
  # The in-game ID of the hero, which is also the number placed on the map,
  # including owned mines.
  def id
    @properties['id']
  end

  ## 
  # Current health of the hero
  def life
    @properties['life']
  end

  ##
  # Returns the current x/y coordinates of the hero in a hash.
  def position
    { x: @properties['pos']['x'], y: @properties['pos']['y'] }
  end

  ##
  # Where is the hero headed to, i.e., what was his last move?
  def direction
    @properties['lastDir'].downcase.to_sym
  end

  ## 
  # Current amount of gold the hero owns
  def gold
    @properties['gold']
  end

  ##
  # Has the hero's software crashed?
  def crashed?
    @properties['crashed']
  end

  ##
  # Low-level access to the properties
  def [](sym)
    sym = sym.to_s if sym.is_a? Symbol
    @properties[sym]
  end
end
