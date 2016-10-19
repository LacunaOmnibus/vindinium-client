require 'minitest/autorun'
require 'webmock/minitest'

class ClientTest < MiniTest::Unit::TestCase
  def setup
    stub_request(:post, 'http://vindinium.org/api/training')
      .with(body: "{\"key\":\"my_key\"}")
      .to_return({ status: 200,
                   body: File.new(
                     File.expand_path __FILE__ + '/../webmock/game_state.json'),
                   headers: {}})
  end

  def test_that_it_does_an_api_call
    client = Vindinium::Client.new 'my_key'
    state = client.api_call Vindinium::Client::BASE_URI_TRAINING

    assert state.has_key? 'game'
  end

  def test_that_it_raises_on_error
    stub_request(:post, 'http://vindinium.org/api/training')
      .with(body: "{\"key\":\"wrong_key\"}")
      .to_return(status: 400, body: "You supplied the wrong key")
    client = Vindinium::Client.new 'wrong_key'
    assert_raises RuntimeError do
      client.api_call Vindinium::Client::BASE_URI_TRAINING
    end
  end
end
