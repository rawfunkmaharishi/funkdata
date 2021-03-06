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

    def self.get_gigs
      GigFetcher.get_gigs
    end

    def self.get_thing thing
      YAML.load get([CONFIG['github']['urls']['raw'], CONFIG['github']['paths'][thing]].join('/'))
    end

    def self.photographer name
      get_photographers.select { |p| p['name'] == name }[0].delete_if { |k, v| v == {} }
    end

    def self.method_missing method_name
      mname = method_name.to_s

      if mname[0..3] == 'get_'
        subject = mname[4..-1]
        thing = self.send(:get_thing, subject)

        if subject == 'videos'
          thing.each do |t|
            t['url'] = "https://vimeo.com/#{t['id']}"
          end
        end

        if subject == 'pictures'
          thing.each do |t|
            t['photographer'] = photographer(t['photographer'])
            t['url'] = t['photo_page']
            t.delete 'photo_page'
            t.delete 'photo_url'
          end
        end

        if subject == 'photographers'
          thing = thing.keys.map { |p| {'name' => p, 'website' => thing.dig(p, 'website') || {} }}
        end

        thing.each do |t|
          if t.has_key? 'license'
            t['license'] = {
              'type' => t['license'],
              'url' => t['license_url']
            }
            t.delete 'license_url'
          end
        end

        cleaned_thing = []
        thing.each do |t|
          clean = {}
          field_orderer(t.keys).each do |k|
            clean[k] = t[k] if t[k]
          end
          cleaned_thing.push clean
        end

        cleaned_thing
      end
    end

    def self.field_orderer fields
      fields.delete 'id'
      prime_fields = [
        'title',
        'date',
        'url',
        'license'
      ]

      remainder = fields - prime_fields
      prime_fields + remainder
    end
  end
end

class String
  def titlecase
    "#{self[0].upcase}#{self[1..-1]}"
  end
end
