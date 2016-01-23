require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'httparty'
require 'redis'
require 'dotenv'

require_relative 'funkdata/racks'
require_relative 'funkdata/helpers'
require_relative 'funkdata/version'
require_relative 'funkdata/fetcher'
require_relative 'funkdata/gig_fetcher'

Dotenv.load

module Funkdata
  class App < Sinatra::Base
    helpers do
      include Funkdata::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @title = 'data.rawfunkmaharishi.uk'
          erb :index, layout: :default
        end

        wants.json do
          e = request.env
          l = []
          [
            'gigs',
            'sounds',
            'pictures',
            'videos',
            'photographers'
          ].each do |ting|
            h = {name: ting}
            h[:url] = "#{e['rack.url_scheme']}://#{e['SERVER_NAME']}/#{ting}"
            l.push h
          end

          l.to_json
        end
      end
    end

    get '/:path' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.json do
          Fetcher.send("get_#{params[:path]}").to_json
        end

        wants.html do
          redirect to "http://rawfunkmaharishi.uk/#{params[:path]}"
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
