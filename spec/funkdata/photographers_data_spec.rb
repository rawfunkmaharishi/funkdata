module Funkdata
  describe Fetcher do
    context 'photographer data' do
      it 'lists the photographers', :vcr do
        expect(described_class.get_photographers).to be_an Array
        expect(described_class.get_photographers.first['name']).to eq 'kim'
      end

      it 'gets a photographer', :vcr do
        expect(described_class.photographer 'kim').to eq (
          {
            'name' => 'kim',
            'website' => 'http://www.kimberlycabbott.com/'
          }
        )
      end
    end
  end
end
