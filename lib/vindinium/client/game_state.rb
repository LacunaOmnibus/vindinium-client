require 'uri'
require 'json'
require 'net/http'

class Vindinium::Client::GameState

  ##
  # Creates a new GameState object and initializes it from the current json.
  def initialize(key, initial_json)
    @key = key
    @data = initial_json
  end

  ##
  # Returns +true+ for as long as moves can be made.
  def running?
    !@data['game']['finished']
  end

  ##
  # Commits the next move and sends it to the server. The +direction+
  # parameter must be one of +:north+, +:east+, +:sourth+, or +:west+.
  #
  # This method updates the GameState object.
  def move!(direction)
    direction = direction.to_s.capitalize
    Net::HTTP::post_form @data['playUrl'], JSON.encode({ key: @key, direction: direction })
  end
end
