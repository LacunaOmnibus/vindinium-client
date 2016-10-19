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
end
