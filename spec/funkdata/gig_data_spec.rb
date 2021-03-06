module Funkdata
  describe GigFetcher do
    context 'gig data' do
      it 'lists gig YAMLs', :vcr do
        expect(described_class.list_gigs).to be_an Array
        expect(described_class.list_gigs.first['_links']['self']).to eq (
          'https://api.github.com/repos/rawfunkmaharishi/rawfunkmaharishi.github.io/contents/gigs/_posts/2013-12-05-269-bar.md?ref=master'
        )
      end

      it 'fetches gig data', :vcr do
        expect(described_class.get_gig 'https://api.github.com/repos/rawfunkmaharishi/rawfunkmaharishi.github.io/contents/gigs/_posts/2015-10-13-the-comedy.md?ref=master').to include (
          {
            'venue' => 'The Comedy',
            'location' => 'The Comedy, Oxendon St, SW1',
            'date' => '2015-10-13',
            'time' => '21:00',
            'price' => {
              'amount' => 6.0,
              'currency' => 'GBP'
            },
            'latitude' => 51.50979,
            'longitude' => -0.13204,
            'url' => 'http://rawfunkmaharishi.uk/gigs/2015/10/13/the-comedy/',
            'facebook-event' => 'https://www.facebook.com/events/1629672733949677/'
          }
        )
      end

      it 'gets all the gigs', :vcr do
        expect(described_class.get_gigs).to be_an Array
      end

      it 'extracts a venue name' do
        expect(described_class.get_venue '2015-10-13-the-comedy.md').to eq 'The Comedy'
      end

      it 'extracts a date' do
        expect(described_class.get_date '2015-10-13-the-comedy.md').to eq '2015-10-13'
      end

      it 'gets a price' do
        expect(described_class.get_price '£6').to eq (
          {
            'amount' => 6,
            'currency' => 'GBP'
          }
        )
      end

      it 'constructs a URL' do
        expect(described_class.gig_url '2015-10-13-the-comedy.md').to eq 'http://rawfunkmaharishi.uk/gigs/2015/10/13/the-comedy/'
      end
    end
  end
end
