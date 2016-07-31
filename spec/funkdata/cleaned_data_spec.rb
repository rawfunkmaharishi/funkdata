module Funkdata
  describe Fetcher do
    it 'presents the data in a consistent order', :vcr do
      expect(described_class.get_pictures[3]).to eq (
        {
          'title' => 'Cafe 1001, March 2016',
          'date' => '2016-03-24',
          'url' => 'https://www.flickr.com/photos/rawfunkmaharishi/25757529640/',
          'license' => {
            'type' => 'Attribution-NonCommercial-ShareAlike',
            'url' => 'https://creativecommons.org/licenses/by-nc-sa/2.0/'
          },
          'photographer' => {
            'name' => 'gary'
          }
        }
      )

      expect(described_class.get_sounds[0]).to eq (
        {
          'title' => 'Mudskipper',
          'date' => '2016-07-25',
          'url' => 'http://soundcloud.com/rawfunkmaharishi/mudskipper',
          'license' => {
            'type' => 'Attribution-NonCommercial-ShareAlike',
            'url' => 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
          },
          'location' => 'Vine Yard Studios'
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
