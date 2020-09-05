require 'sinatra'
require_relative 'url_shortener'

get '/' do
  erb :index
end

post '/short' do
  url = params[:url]
  short_hash = Shortener.short(url)
  @shortener = "http://localhost:4567/#{short_hash}"

  erb :index
end

get '/:short' do
  short = params[:short]
  final_url = Shortener.redirect(short)
  redirect final_url
end
