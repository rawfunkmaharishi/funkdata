module Funkdata
  describe Fetcher do
    context 'photographer data' do
      it 'lists the photographers', :vcr do
        expect(described_class.get_photographers).to be_a Hash
        expect(described_class.get_photographers['kim']).to eq (
          {
            'website' => 'http://www.kimberlycabbott.com/'
          }
        )
        expect(described_class.get_photographers['sam']).to eq ({})
      end
    end
  end
end
