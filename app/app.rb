ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require './app/models/link.rb'
require_relative 'data_mapper_setup'
require 'byebug'

class Bookmark < Sinatra::Base
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/add' do
    erb :'links/add'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split.each do |append|
      link.tags << Tag.create(tags: append)
    end
    link.save
    redirect '/links'
  end


  get '/tags/:tags' do
    tag = Tag.all(tags: params[:tags])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
