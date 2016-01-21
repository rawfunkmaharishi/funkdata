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

    def self.list_gigs
      url = [CONFIG['base_url'], CONFIG['gig_path']].join '/'
      j = JSON.parse get(url)
      j.select { |g| g['_links']['self'].match /yml\?/ }
    end

    def self.get_gig url
      y = YAML.load(get(url))
      y['data'] = YAML.load(get(y['download_url']))
      y['data']['venue'] = get_venue y['name']
      y['data']['date'] = get_date y['name']
      y['data'].delete 'facebook_id'
      y
    end

    def self.get_gigs
      list_gigs.map { |g| get_gig(g['_links']['self'])['data'] }
    end

    def self.get_venue s
      s.match(/....-..-..-(.*)\.yml/)[1].split('-').map { |w| w.titlecase }.join ' '
    end

    def self.get_date s
      s.match(/(....-..-..).*/)[1]
    end
  end
end

class String
  def titlecase
    "#{self[0].upcase}#{self[1..-1]}"
  end
end
