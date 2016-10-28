module Funkdata
  class GeoJSON
    def self.data
      gigs = GigFetcher.get_gigs
      venues = gigs.map do |g|
        {
          geometry: {
            type: 'Point',
            coordinates: [
              g['longitude'],
              g['latitude']
            ]
          },
          type: 'Feature',
          properties: {
            name: g['venue']
          }
        }
      end.uniq

      venues.each do |venue|
        venue[:properties][:gigs] = gigs.select do |g|
          g['venue'] == venue[:properties][:name]
        end.map do |s|
          {
            date: s['date'],
            url: s['url']
          }
        end
      end

      {
        type: 'FeatureCollection',
        features: venues
      }
    end
  end
end
