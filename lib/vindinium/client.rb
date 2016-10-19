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
    #     game_state.turn :north
    #   end
    #
    # There are two optional parameters: +turns+ and +map+. If +turns+ is
    # unset, 300 turns are assumed. The +map+ parameter takes one of +:m1+,
    # +:m2+, +:m3+, +:m4+, +:m5+, +:m6+. If no parameter is supplied, a random
    # map is generated.
    def start_training(turns: 300, map: nil)
      params = { turns: turns }
      params[:map] = map if map

      GameState.new @key, api_call(BASE_URI_TRAINING, params)
    end

    def start_arena_match
      GameState.new @key, api_call(BASE_URI_ARENA)
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
  end
end

require 'vindinium/client/map'
require 'vindinium/client/tile'
require 'vindinium/client/hero_tile'
require 'vindinium/client/mine_tile'
require 'vindinium/client/game_state'
