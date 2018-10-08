require 'sinatra'
require 'redis'
require 'flickraw'
require 'json'
require 'dotenv'
require 'slim'
require 'http'
require 'rack/ssl'

use Rack::SSL, :exclude => lambda { |env| ENV['RACK_ENV'] != 'production' }
use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == "#{ENV['FLICKR_WRAP_USERNAME']}" and password == "#{ENV['FLICKR_WRAP_PASSWORD']}"
end

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
  register JsonExceptions
  set :bind, '0.0.0.0'
end

configure :test do
end

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
  register JsonExceptions
end

redis_url = 'redis://127.0.0.1:6379'
redis_url ||= ENV['REDIS_URL']
redis     = Redis.new(url: redis_url)

FlickRaw.api_key       = ENV['FLICKR_API_KEY']
FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
flickr.access_token    = ENV['FLICKR_ACCESS_TOKEN']
flickr.access_secret   = ENV['FLICKR_ACCESS_SECRET']
user                   = ENV['FLICKR_USER']

login = flickr.test.login
puts "You are now authenticated as #{login.username}"

def timenow
  date_and_time = '%Y-%b-%d %H:%M:%S'
  Time.now.strftime(date_and_time)
end

# before do
#   if settings.production?
#     redirect request.url.sub('http', 'https') unless request.secure?
#   end
# end

get '/' do
  @images = []

  redis.keys("flickr_*").each do |key|
    @images << JSON.parse(redis.get("#{key}"))
  end

  @images.sort_by! { |i| i['filename'] }
  slim :images, layout: :index
end

post '/sync' do
  child_pid = Process.fork do
    per_page = params['count']
    per_page ||= 500
    photos = flickr.photos.search(user_id: user, per_page: per_page)
    photos.each do |photo|
      info = flickr.photos.getInfo(photo_id: photo.id)
      url = FlickRaw.url_o(info)
      url_small = FlickRaw.url_t(info)
      hash = {id: photo.id, filename: info['title'], url: url, preview: url_small}
      redis.set("flickr_#{info['title']}", hash.to_json)
    end
    Process.exit
  end

  Process.detach child_pid # No zombie process

  return 200, {message: "Doing hard work in the background"}.to_json
end

post '/delete' do
  params['checkbox'].each do |i|
    image = JSON.parse(redis.get("flickr_#{i}"))
    if flickr.photos.delete(:photo_id => image['id'])
      redis.del("flickr_#{i}")
    end
  end
end

get '/upload' do
  slim :upload, layout: :index
end

post '/upload' do
  redirect '/upload', 'No file specified' if params['images'].nil?
  params['images'].each do |i|
    flickr.upload_photo(
      i[:tempfile],
      title: "#{i[:filename]}",
      description: "#{i[:filename]} uploaded through API at #{timenow}!",
      tags: "#{i[:filename]}"
    )
    # HTTP.post("http://#{request.host}:#{request.port}/sync")
  end
  redirect '/'
end
