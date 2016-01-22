[![Build Status](http://img.shields.io/travis/rawfunkmaharishi/funkdata.svg?style=flat-square)](https://travis-ci.org/rawfunkmaharishi/funkdata)
[![Dependency Status](http://img.shields.io/gemnasium/rawfunkmaharishi/funkdata.svg?style=flat-square)](https://gemnasium.com/rawfunkmaharishi/funkdata)
[![Coverage Status](http://img.shields.io/coveralls/rawfunkmaharishi/funkdata.svg?style=flat-square)](https://coveralls.io/r/rawfunkmaharishi/funkdata)
[![Code Climate](http://img.shields.io/codeclimate/github/rawfunkmaharishi/funkdata.svg?style=flat-square)](https://codeclimate.com/github/rawfunkmaharishi/funkdata)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://rawfunkmaharishi.mit-license.org)

# data.rawfunkmaharishi.uk

_A data API for the band_

The [band website](http://rawfunkmaharishi.uk/) is very [data-driven](http://rawfunkmaharishi.uk/blog/2014/11/12/being-data-driven/#data-driven-gigs), but [Jekyll](http://jekyllrb.com/) (at least on Github Pages) will not let us publish JSON. This clearly needs to be fixed.

## Content negotiation

The API will respond to the following _Accept_ values with appropriate content:

### `application/json`

Content will be returned as JSON.

## API

### `/`

Returns a list of available endpoints.

### `/gigs`

Returns a list of gig metadata.

### `/sounds`

Returns a list of music metadata.

### `/pictures`

Returns a list of photograph metadata.

### `/videos`

Returns a list of video metadata.

**More endpoints coming soon.**

## Your questions answered

### How does this work?

It's pulling data from the [Jekyll](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/tree/master/gigs/_posts) [sources](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/tree/master/_data), clouting it into shape, and serving it up as JSON. There's _no_ database here (yet), just a bit of Redis caching.

### Why _data.rawfunkmaharishi.uk_?

As a very wise person once told me, _Your website is your API_ - I'd very much prefer to serve this data from the main domain via content-negotiation, but Github Pages won't let me. If I find a satisfactory solution to this then this will definitely move there. For now, a request for _text/html_ will see your client redirected to the same path on the main website (apart from _/_, obviously).

What I'm trying to say is, this is quite possibly a temporary arrangement and should be considered _extremely_ alpha (like anybody's ever going to use this).

### Why are you doing this?

Have you _met_ me?

## Licensing

All of this data is released under a [Creative Commons Attribution Share-alike license](http://creativecommons.org/licenses/by-sa/4.0/).
