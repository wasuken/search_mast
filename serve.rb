require 'sqlite3'
require 'sequel'
require 'sinatra'

DB = Sequel.sqlite('toot.sqlite3')

get '/json' do
  @toot_json = get_toot()
  get_toot().to_s
end

get '/' do
  erb :index
end

get '/search' do
  # if params[:fmt] == "json"
  # params[:words] == ",,,,..."
end

def get_toot(fmt="json",words=[])
  DB[:toot].order(Sequel.desc(:id)).limit(10).all.to_json
end
