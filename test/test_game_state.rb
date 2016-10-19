require 'minitest/autorun'

class GameStateTest < MiniTest::Unit::TestCase
  def setup
    @finished_game_state = JSON.parse File.read(
      File.expand_path(__FILE__ + '/../webmock/game_state.json'))
  end

  def test_that_it_checks_running
    state = Vindinium::Client::GameState.new('key', @finished_game_state)
    assert !state.running?
  end

  def test_that_it_sends_the_move_action
    stub_move = stub_request(
        :post, "http://localhost:9000/api/s2xh3aig/lte0/play")
      .with(body: "{\"key\":\"key\",\"direction\":\"North\"}")
      .to_return(status: 200, body: @finished_game_state.to_json)

    state = Vindinium::Client::GameState.new('key', @finished_game_state)
    state.move! :north

    assert_requested(stub_move)
  end
end
