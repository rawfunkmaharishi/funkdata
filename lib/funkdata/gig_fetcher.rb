module Funkdata
  class GigFetcher < Fetcher
    def self.list_gigs
      url = [CONFIG['github']['urls']['api'], CONFIG['github']['paths']['gigs']].join '/'
      j = JSON.parse get(url)
      j.select { |g| g['name'].match /^2.*md$/ }
    end

    def self.get_gig url
      y = YAML.load(get(url))
      data = YAML.load(get(y['download_url']))

      z = {}
      z['venue'] = get_venue y['name']
      z['location'] = data['location']
      z['date'] = get_date y['name']
      z['time'] = data['time']
      z['price'] = get_price data['price'] if data['price']
      z['latitude'] = data['latitude']
      z['longitude'] = data['longitude']
      z['url'] = gig_url y['name']
      z['facebook-event'] = "https://www.facebook.com/events/#{data['facebook_id']}/" if data['facebook_id']

      z
    end

    def self.get_gigs
      list_gigs.map { |g| get_gig(g['_links']['self']) }
    end

    def self.get_price p
      parts = p.match(/([^0-9])*([0-9]*)/)
      {
        'amount' => parts[2].to_f,
        'currency' => case parts[1]
                        when /£/
                          'GBP'
                        else
                         'GBP'
                        end
      }
    end

    def self.get_venue s
      split_name(s)[:venue].split('-').map { |w| w.titlecase }.join ' '
    end

    def self.get_date s
      split_name(s)[:date]
    end

    def self.split_name s
      m = s.match(/(....-..-..)-(.*)\.md/)
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
