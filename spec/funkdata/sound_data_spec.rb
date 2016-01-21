module Funkdata
  describe Fetcher do
    context 'sound data' do
      it 'lists the sounds', :vcr do
        pending 'until Purdie is fixed'
        expect(described_class.get_sounds).to be_an Array
      end
    end
  end
end
