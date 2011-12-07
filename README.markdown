Rake Routes Normalizer
------------------------

rake_routes_normalizer is a utility for migrating routes from Rails 2 to 3.
It can normalize the printout of `rake routes` so that it's easier to diff
Rails 2 to 3 routes.

(Yes, Rails 3 was released last year. But better late than never.)

With rake_routes_normalizer, you can transform this:

         user_session POST   /user_session(.:format)      {:action=>"create", :controller=>"user_sessions"}
     new_user_session GET    /user_session/new(.:format)  {:action=>"new", :controller=>"user_sessions"}
    edit_user_session GET    /user_session/edit(.:format) {:action=>"edit", :controller=>"user_sessions"}
                      PUT    /user_session(.:format)      {:action=>"update", :controller=>"user_sessions"}
                      DELETE /user_session(.:format)      {:action=>"destroy", :controller=>"user_sessions"}

Into this!

    /user_session(.:format)       DELETE  user_session        {"action"=>"destroy", "controller"=>"user_sessions"}
    /user_session(.:format)       POST    user_session        {"action"=>"create", "controller"=>"user_sessions"}
    /user_session(.:format)       PUT     user_session        {"action"=>"update", "controller"=>"user_sessions"}
    /user_session/edit(.:format)  GET     edit_user_session   {"action"=>"edit", "controller"=>"user_sessions"}
    /user_session/new(.:format)   GET     new_user_session    {"action"=>"new", "controller"=>"user_sessions"}


Usage
=====

In a rails directory:

    rake routes | rake_routes_normalizer

Or if you saved the `rake routes` printout:

    rake_routes_normalizer rake_routes_printout.txt

Install
=======

    gem install rake_routes_normalizer


