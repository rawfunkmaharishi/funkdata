module Funkdata
  describe Fetcher do
    context 'picture data' do
      it 'lists the pictures', :vcr do
        expect(described_class.get_pictures).to be_an Array
        expect(described_class.get_pictures.first['date']).to eq '2016-03-24'
        expect(described_class.get_pictures[1]['license']).to eq (
          {
            'type' => 'Attribution-NonCommercial-ShareAlike',
            'url' => 'https://creativecommons.org/licenses/by-nc-sa/2.0/'
          }
        )
        expect(described_class.get_pictures[1]['photographer']).to eq (
          {
            'name' => 'gary'
          }
        )

        expect(described_class.get_pictures[2]['url']).to eq (
          'https://www.flickr.com/photos/rawfunkmaharishi/26004429386/'
        )
      end
    end
  end
end
