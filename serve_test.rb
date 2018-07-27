require "./serve"
require "minitest/autorun"
require "rack/test"

ENV['RACK_ENV'] = 'test'


class ServeTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_response_ok?
    get '/'
    assert last_response.ok?
  end

  def test_it_search_response_ok?
    get '/search?words=emacs,vim'
    assert last_response.ok?
  end

  def test_it_search_response_json?
    get '/user?users=emacs,vim'
    assert last_response.ok?
  end

end
