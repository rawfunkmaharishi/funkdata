require 'rack/conneg'

module Funkdata
  class App < Sinatra::Base
    set :public_folder, 'public'
    set :views, 'views'

    use Rack::Conneg do |conneg|
      conneg.set :accept_all_extensions, false
      conneg.set :fallback, :html
      conneg.ignore_contents_of 'public'
      conneg.provide [
        :html,
        :json
      ]
    end

    before do
      if negotiated?
        content_type negotiated_type
      end
    end
  end
end
