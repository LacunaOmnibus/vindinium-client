require 'uri'
require 'json'
require 'net/http'

module Vindinium # :nodoc:
  class Client
    VERSION = '0.0.1'.freeze
    BASE_URI_ARENA = URI('http://vindinium.org/api/arena')
    BASE_URI_TRAINING = URI('http://vindinium.org/api/training')

    ##
    # Creates a new client by supplying the client's (i.e., the bot's) API
    # key.
    def initialize(key)
      @key = key
    end

    ##
    # Starts a training match.
    #
    #   Client.new(my_key).start_training do |game_state|
    #     # Some thinking...
    #     :north
    #   end
    #
    # There are two optional parameters: +turns+ and +map+. If +turns+ is
    # unset, 300 turns are assumed. The +map+ parameter takes one of +:m1+,
    # +:m2+, +:m3+, +:m4+, +:m5+, +:m6+. If no parameter is supplied, a random
    # map is generated.
    #
    # Instead of returning a direction, you can also call GameState#move!(dir)
    # with one of the permitted direction indicators
    # (+:north+, +:east+, +:south+, +:west+).
    def start_training(turns: 300, map: nil) # :yields: game_state
      params = { turns: turns }
      params[:map] = map if map

      game_state = GameState.new @key, api_call(BASE_URI_TRAINING, params)
      run_game game_state, Proc.new if block_given?

      game_state
    end

    ##
    # Starts an arena match against other bots.
    #
    #   Client.new(my_key).start_training do |game_state|
    #     # Some thinking...
    #     game_state.turn! :north
    #   end
    #
    # It might take some time until the initial API call returns. This happens
    # when not enough bots are only to play a match. Just be patient, then;
    # Vindinium::Client certainly is.
    #
    # Instead of using GameState#move!(dir), you can also return one of the
    # permitted direction indicators (+:north+, +:east+, +:south+, +:west+).
    def start_arena_match # :yields: game_state
      game_state = GameState.new @key, api_call(BASE_URI_ARENA)
      run_game game_state, Proc.new if block_given?
      game_state
    end

    ##
    # Performs the low-level HTTP POST call and returns the result.
    #
    # Usually, the Client#start_training or Client#start_arena_match methods
    # should be used.
    def api_call(uri, params = {})
      req = Net::HTTP::Post.new uri
      req.body = params.merge({ key: @key }).to_json
      req['User-Agent'] = 'Vindium-Client/Ruby'

      res = Net::HTTP.start(uri.hostname, uri.port,
                            use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
      end

      raise res.body if res.code.to_i >= 400
      JSON.parse res.body
    end

    private

    def run_game(game_state, block)
      turn = game_state.turn
      while game_state.running?
        direction = block.call game_state
        game_state.move! direction if game_state.turn == turn
      end
    end
  end
end

require 'vindinium/client/map'
require 'vindinium/client/hero'
require 'vindinium/client/tile'
require 'vindinium/client/hero_tile'
require 'vindinium/client/mine_tile'
require 'vindinium/client/game_state'
