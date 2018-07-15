require 'sqlite3'
require 'sequel'
require 'mastodon'
require 'parseconfig'

MYCONF=ParseConfig.new('config')

TOKEN=MYCONF['mastodon_token']
client =  Mastodon::Streaming::Client.new(base_url: 'https://mastodon.social', bearer_token: TOKEN)
DB = Sequel.sqlite('toot.sqlite3')

begin
  client.firehose do |toot|
    next if !toot.kind_of?(Mastodon::Status)
    username = toot.account.username
    content = toot.content
    DB[:toot].insert(username: username, toot: content)
    puts "#{username}: #{content}"
  end
rescue EOFError => e
  puts "\nretry..."
  retry
end
