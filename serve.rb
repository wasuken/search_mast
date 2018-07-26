# coding: utf-8
require 'sqlite3'
require 'sequel'
require 'sinatra'

DB = Sequel.sqlite('toot.sqlite3')

get '/json' do
  get_lasted_toot.to_s
end

get '/' do
  erb :index
end

get '/search' do
  redirect '/' if params["words"].nil?
  opt = params["opt"] || "or"
  fmt = params["fmt"]  || "json"
  if params["words"].nil?
    redirect '/json' if fmt=="json"
    redirect '/'
  end
  DB[:toot].all
    .select{|t| include_opt_map?(opt, t[:toot], params["words"].split(','))}
    .to_s
end
get '/user' do
  redirect '/' if params["users"].nil?
  users = params["users"].split(",")
  DB[:toot].where(:username => users).select(:username).all.to_s
end
# opt=or  -> 文字列targetがwordsのいずれかを含む場合、true
# opt=and -> 文字列targetがwordsのすべてを含む場合,true
# optが上記以外はすべてfalse
def include_opt_map?(opt,target,words)
  if opt=="and"
    words.all?{|w| target.include?(w) }
  elsif opt=="or"
    words.any?{|w| target.include?(w) }
  end
end

def get_lasted_toot(fmt="json",words=[],take=10)
  DB[:toot].order(Sequel.desc(:id)).limit(take).all.to_json
end
