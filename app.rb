require 'sinatra'
require 'sinatra/reloader'
require 'redis'
require 'flickraw'
require 'json'
require 'dotenv'

Dotenv.load

configure :production do
end

configure :test do
end

configure :development do
end

# Create redis object with connection
redis = Redis.new

FlickRaw.api_key       = ENV['FLICKR_API_KEY']
FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
flickr.access_token    = ENV['FLICKR_ACCESS_TOKEN']
flickr.access_secret   = ENV['FLICKR_ACCESS_SECRET']
user                   = ENV['FLICKR_USER']

login = flickr.test.login
puts "You are now authenticated as #{login.username}"

get '/' do
  @images = ""
  redis.keys("flickr_*").each do |key|
    value = JSON.parse(redis.get("#{key}"))
    puts value
  end
  return 200, "DONE"
end

get '/sync' do
  photos = flickr.photos.search(user_id: user, per_page: 10)
  photos.each do |photo|
    info = flickr.photos.getInfo(photo_id: photo.id)
    url = FlickRaw.url_o(info)
    url_small = FlickRaw.url_t(info)
    hash = {id: photo.id, filename: info['title'], url: url, preview: url_small}
    redis.set("flickr_#{info['title']}", hash.to_json)
  end
  return 200, "DONE"
end
