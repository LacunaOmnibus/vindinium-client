##
# An actual hero on the map
class Vindinium::Client::Hero

  ##
  # Initializes the hero with raw data hash retrived from the JSON game state.
  def initialize(properties)
    @properties = properties
  end
end
