module Funkdata
  describe Fetcher do
    it 'presents the data in a consistent order', :vcr do
      expect(described_class.get_pictures[3]).to eq (
        {
          'title' => 'Raw Funk Maharishi',
          'date' => '2015-02-18',
          'url' => 'https://www.flickr.com/photos/cluttercup/16395047119/',
          'license' => {
            'type' => 'Attribution-NonCommercial',
            'url' => 'https://creativecommons.org/licenses/by-nc/2.0/'
          },
          'photographer' => {
            'name' => 'jane',
            'website' => 'https://www.flickr.com/photos/cluttercup'
          }
        }
      )

      expect(described_class.get_sounds[0]).to eq (
        {
          'title' => 'NRF',
          'date' => '2016-01-20',
          'url' => 'http://soundcloud.com/rawfunkmaharishi/nrf',
          'license' => {
            'type' => 'Attribution-NonCommercial-ShareAlike',
            'url' => 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
          },
          'location' => 'Rogue Studios'
        }
      )

      expect(described_class.get_videos[0]).to eq (
      {
        'title' => 'Vilamendhoo 2015',
        'url' => 'https://vimeo.com/141292006',
        'license' => {
          'type' => 'Attribution-NonCommercial-ShareAlike',
          'url' => 'http://creativecommons.org/licenses/by-nc-sa/3.0/'
          }
        }
      )
    end
  end
end
