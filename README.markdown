Rake Routes Normalizer
------------------------

rake_routes_normalizer is a utility for migrating routes from Rails 2 to 3.
It can normalize the printout of `rake routes` so that it's easier to diff
Rails 2 to 3 routes.

(Yes, Rails 3 was released last year. But better late than never.)

Usage
=====

In a rails directory:

    rake routes | rake_routes_normalizer

Or if you saved the `rake routes` printout:

    rake_routes_normalizer rake_routes_printout.txt

Install
=======

    gem install rake_routes_normalizer


