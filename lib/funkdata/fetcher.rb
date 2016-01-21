module Funkdata
  class Fetcher
    REDIS = Redis.new
    CONFIG = YAML.load_file 'config/config.yml'

    def self.redis
      REDIS
    end

    def self.headers
      {
        'Accept' => 'application/vnd.github.v3+json',
        'User-agent' => "Funkdata v#{VERSION}"
      }
    end

    def self.query
      {
        'client_id' => ENV['GITHUB_CLIENT_ID'],
        'client_secret' => ENV['GITHUB_CLIENT_SECRET']
      }
    end

    def self.get url, ttl = 3600
      begin
        Marshal.load(self.redis.get url)
      rescue TypeError
        h = HTTParty.get url, headers: headers, query: query
        self.redis.set url, Marshal.dump(h.body)
        self.redis.expire url, ttl
        Marshal.load(self.redis.get url)
      end
    end

    def self.get_sounds
    #  require "pry" ; binding.pry
    end

    def self.get_pictures
      YAML.load get([CONFIG['github']['raw_url'], CONFIG['github']['pictures_path']].join('/'))
    end

    def self.list_gigs
      url = [CONFIG['github']['api_url'], CONFIG['github']['gig_path']].join '/'
      j = JSON.parse get(url)
      j.select { |g| g['_links']['self'].match /yml\?/ }
    end

    def self.get_gig url
      y = YAML.load(get(url))
      data = YAML.load(get(y['download_url']))

      z = {}
      z['venue'] = get_venue y['name']
      z['location'] = data['location']
      z['date'] = get_date y['name']
      z['time'] = data['time']
      z['price'] = data['price'] if data['price']
      z['latitude'] = data['latitude']
      z['longitude'] = data['longitude']
      z['url'] = gig_url y['name']
      z['facebook-event'] = "https://www.facebook.com/events/#{data['facebook_id']}/" if data['facebook_id']

      z
    end

    def self.get_gigs
      list_gigs.map { |g| get_gig(g['_links']['self']) }
    end

    def self.get_venue s
      split_name(s)[:venue].split('-').map { |w| w.titlecase }.join ' '
    end

    def self.get_date s
      split_name(s)[:date]
    end

    def self.split_name s
      m = s.match(/(....-..-..)-(.*)\.yml/)
      {
        date: m[1],
        venue: m[2]
      }
    end

    def self.gig_url s
      [
        CONFIG['rfm']['base_url'],
        CONFIG['rfm']['gig_path'],
        get_date(s).gsub('-', '/'),
        split_name(s)[:venue]
      ].join('/') + '/'
    end
  end
end

class String
  def titlecase
    "#{self[0].upcase}#{self[1..-1]}"
  end
end
