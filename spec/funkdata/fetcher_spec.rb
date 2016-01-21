module Funkdata
  describe Fetcher do
    it 'lists gig YAMLs', :vcr do
      expect(described_class.list_gigs).to be_an Array
      expect(described_class.list_gigs.first['_links']['self']).to eq (
        'https://api.github.com/repos/rawfunkmaharishi/rawfunkmaharishi.github.io/contents/gigs/_posts/2013-12-05-269-bar.yml?ref=master'
      )
    end

    it 'fetches gig data', :vcr do
      expect(described_class.get_gig 'https://api.github.com/repos/rawfunkmaharishi/rawfunkmaharishi.github.io/contents/gigs/_posts/2015-10-13-the-comedy.yml?ref=master').to include (
        {
          'name' => '2015-10-13-the-comedy.yml',
          'data' => {
            'venue' => 'The Comedy',
            'location' => 'The Comedy, Oxendon St, SW1',
            'date' => '2015-10-13',
            'time' => '21:00',
            'price' => '£6',
            'latitude' => 51.50979,
            'longitude' => -0.13204,
            'url' => 'http://rawfunkmaharishi.uk/gigs/2015/10/13/the-comedy/'
      #      'facebook-event' => 'https://www.facebook.com/events/1629672733949677/'
          }
        }
      )
    end

    it 'gets all the gigs', :vcr do

    end

    it 'extracts a venue name' do
      expect(described_class.get_venue '2015-10-13-the-comedy.yml').to eq 'The Comedy'
    end

    it 'extracts a date' do
      expect(described_class.get_date '2015-10-13-the-comedy.yml').to eq '2015-10-13'
    end

    it 'constructs a URL' do
      expect(described_class.gig_url '2015-10-13-the-comedy.yml').to eq 'http://rawfunkmaharishi.uk/gigs/2015/10/13/the-comedy/'
    end
  end
end
