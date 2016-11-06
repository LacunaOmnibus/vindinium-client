require 'minitest/autorun'

class GameStateTest < MiniTest::Unit::TestCase
  def setup
    @initial_game_state = JSON.parse File.read(
      File.expand_path(__FILE__ + '/../webmock/initial_game_state.json'))
    @finished_game_state = JSON.parse File.read(
      File.expand_path(__FILE__ + '/../webmock/game_state.json'))
  end

  def test_that_it_checks_running
    state = Vindinium::Client::GameState.new 'key', @finished_game_state
    assert !state.running?
  end

  def test_that_it_sends_the_move_action
    stub_move = stub_request(
        :post, "http://localhost:9000/api/s2xh3aig/lte0/play")
      .with(body: "{\"key\":\"key\",\"direction\":\"North\"}")
      .to_return(status: 200, body: @finished_game_state.to_json)

    state = Vindinium::Client::GameState.new 'key', @initial_game_state
    assert_equal 1, state.turn

    state.move! :north

    assert_requested(stub_move)
    assert_equal @finished_game_state['game']['turn'], state.turn
  end

  def test_that_it_places_heroes
    state = Vindinium::Client::GameState.new 'key', @finished_game_state
    assert_equal 4, state.heroes.length
    assert state.heroes.include? state.map[4,8].hero
  end

  def test_that_it_finds_us
    state = Vindinium::Client::GameState.new 'key', @finished_game_state
    hero = state.whoami

    assert hero.is_a? Vindinium::Client::Hero
    assert_equal 4, hero.id
  end

  def test_that_it_does_not_move_when_crashed
    crashed_state = @finished_game_state.merge({ "hero" => { "crashed" => true }})
    state = Vindinium::Client::GameState.new 'key', crashed_state
    assert_raises(RuntimeError) { state.move! :north }
  end
end
