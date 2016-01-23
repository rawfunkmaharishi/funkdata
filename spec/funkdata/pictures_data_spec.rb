module Funkdata
  describe Fetcher do
    context 'picture data' do
      it 'lists the pictures', :vcr do
        expect(described_class.get_pictures).to be_an Array
        expect(described_class.get_pictures.first['date']).to eq '2015-07-06'
        expect(described_class.get_pictures[1]['photographer']).to eq (
          {
            'name' => 'jane',
            'website' => 'https://www.flickr.com/photos/cluttercup'
          }
        )
      end
    end
  end
end
