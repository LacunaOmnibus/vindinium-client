require 'uri'
require 'json'
require 'net/http'

class Vindinium::Client::GameState

  ##
  # The game board
  attr_reader :map

  ##
  # Short-cut access to all heroes on the map
  attr_reader :heroes

  ##
  # Creates a new GameState object and initializes it from the current json.
  def initialize(key, initial_json)
    @key = key
    @data = initial_json
    @map = Vindinium::Client::Map.new
    @heroes = []

    update!
  end

  ##
  # Returns +true+ for as long as moves can be made.
  def running?
    !@data['game']['finished']
  end

  ##
  # Current game turn number
  def turn
    @data['turn'].to_i
  end

  ##
  # Maximum number of turns the game runs
  def max_turns
    @data['maxTurns'].to_i
  end

  ##
  # Returns the hero object that represents us.
  def whoami
    @heroes.find { |h| h.id == @data['hero']['id'] }
  end

  ##
  # Commits the next move and sends it to the server. The +direction+
  # parameter must be one of +:north+, +:east+, +:sourth+, or +:west+.
  #
  # This method updates the GameState object.
  def move!(direction)
    unless [:north, :south, :east, :west].include? direction
      raise "Unknown direction: #{direction}"
    end

    direction = direction.to_s.capitalize
    uri = URI(@data['playUrl'])

    req = Net::HTTP::Post.new uri
    req.body = { key: @key, direction: direction }.to_json
    req['User-Agent'] = 'Vindium-Client/Ruby'

    res = Net::HTTP.start(uri.hostname, uri.port,
                          use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
    end

    raise res.body if res.code.to_i >= 400
    @data = JSON.parse res.body
    update!
  end

  ##
  # Updates the game's internal state from its current JSON representation.
  def update!
    @map.from_s @data['game']['board']['tiles']

    # Update the heroes:

    @heroes.clear
    @data['game']['heroes'].each do |h|
      hero = Vindinium::Client::Hero.new h
      @heroes << hero
      @map[h['pos']['x'], h['pos']['y']].hero = hero
    end
  end
end
