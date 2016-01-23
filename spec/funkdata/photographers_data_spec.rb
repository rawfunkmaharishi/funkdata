module Funkdata
  describe Fetcher do
    context 'photographer data' do
      it 'lists the photographers', :vcr do
        expect(described_class.get_photographers).to be_an Array
        expect(described_class.get_photographers.first['name']).to eq 'kim'
      end
    end
  end
end
