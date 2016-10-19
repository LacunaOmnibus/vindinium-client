require 'minitest/autorun'
require 'webmock/minitest'

class ClientTest < MiniTest::Unit::TestCase
  def test_that_it_does_an_api_call
    stub_request(:post, 'http://vindinium.org/api/training')
      .with(body: "{\"key\":\"my_key\"}")
      .to_return(:status => 200, :body => "", :headers => {})

    client = Vindinium::Client.new 'my_key'
    client.api_call Vindinium::Client::BASE_URI_TRAINING
  end
end
