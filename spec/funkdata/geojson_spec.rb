module Funkdata
  describe GeoJSON do
    it 'constructs GeoJSON', :vcr do
      expect(described_class.data[:features]).to include (
        {
          geometry: {
            type: 'Point',
            coordinates: [
              -0.08171,
              51.527817
            ]
          },
          type: 'Feature',
          properties: {
            name: 'Hoxton Underbelly',
            gigs: [
              {
                date: '2014-06-16',
                url: 'http://rawfunkmaharishi.uk/gigs/2014/06/16/hoxton-underbelly/'
              },
              {
                date: '2015-02-17',
                url: 'http://rawfunkmaharishi.uk/gigs/2015/02/17/hoxton-underbelly/'
              },
              {
                date: '2015-08-11',
                url: 'http://rawfunkmaharishi.uk/gigs/2015/08/11/hoxton-underbelly/'
              },
              {
                date: '2015-10-27',
                url: 'http://rawfunkmaharishi.uk/gigs/2015/10/27/hoxton-underbelly/'
              },
              {
                date: '2015-11-23',
                url: 'http://rawfunkmaharishi.uk/gigs/2015/11/23/hoxton-underbelly/'
              },
              {
                date: '2016-02-15',
                url: 'http://rawfunkmaharishi.uk/gigs/2016/02/15/hoxton-underbelly/'
              },
              {
                date: '2016-05-24',
                url: 'http://rawfunkmaharishi.uk/gigs/2016/05/24/hoxton-underbelly/'
              },
              {
                date: '2016-10-24',
                url: 'http://rawfunkmaharishi.uk/gigs/2016/10/24/hoxton-underbelly/'
              }
            ]
          }
        }
      )
    end
  end

  describe App do
    it 'returns GeoJSON' do
      get '/gigs', nil, { 'HTTP_ACCEPT' => 'application/vnd.geo+json' }
    end
  end
end
