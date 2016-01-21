module Funkdata
  describe Fetcher do
    context 'video data' do
      it 'lists the videos', :vcr do
        expect(described_class.get_videos).to be_an Array
        expect(described_class.get_videos.first['id']).to eq 141292006
      end
    end
  end
end
