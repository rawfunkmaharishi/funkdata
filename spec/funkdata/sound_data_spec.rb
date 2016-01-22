module Funkdata
  describe Fetcher do
    context 'sound data' do
      it 'lists the sounds', :vcr do
        expect(described_class.get_sounds).to be_an Array
        expect(described_class.get_sounds.first['url']).to eq 'http://soundcloud.com/rawfunkmaharishi/slinky-2'
      end
    end
  end
end
