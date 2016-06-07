require 'sinatra'
require 'redis'
require 'flickraw'
require 'json'
require 'dotenv'
require 'slim'

Dotenv.load

module JsonExceptions
  def self.registered(app)
    app.set :show_exceptions => false

    app.error { |err|
      Rack::Response.new(
        [{"message": err.message}.to_json],
        500,
        {'Content-type' => 'application/json'}
      ).finish
    }
  end
end

configure :production do
end

configure :test do
end

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
  register JsonExceptions
  set :bind, '0.0.0.0'
end

redis = Redis.new

FlickRaw.api_key       = ENV['FLICKR_API_KEY']
FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
flickr.access_token    = ENV['FLICKR_ACCESS_TOKEN']
flickr.access_secret   = ENV['FLICKR_ACCESS_SECRET']
user                   = ENV['FLICKR_USER']

login = flickr.test.login
puts "You are now authenticated as #{login.username}"

get '/' do
  @images = []
  redis.keys("flickr_*").each do |key|
    @images << JSON.parse(redis.get("#{key}"))
  end
  slim :images, layout: :index
end

post '/sync' do
  # return 400, {"message": "DONE"}.to_json
  per_page = params['count']
  per_page ||= 10
  photos = flickr.photos.search(user_id: user, per_page: per_page)
  photos.each do |photo|
    info = flickr.photos.getInfo(photo_id: photo.id)
    url = FlickRaw.url_o(info)
    url_small = FlickRaw.url_t(info)
    hash = {id: photo.id, filename: info['title'], url: url, preview: url_small}
    redis.set("flickr_#{info['title']}", hash.to_json)
  end
  return 200, {"message": "DONE"}.to_json
end
