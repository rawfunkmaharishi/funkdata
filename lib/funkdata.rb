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
          @content = '<h1>Hello from Funkdata</h1>'
          @title = 'Funkdata'
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'Funkdata'
          }.to_json
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
