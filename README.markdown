Rake Routes Normalizer
------------------------

If you're app is still running in Rails 2.3 (like ours a few weeks ago hehe), then you might find this tool useful when migrating the routes to Rails 3's routing API. It "normalizes" the printout of rake routes so that it's easier to diff pre and post Rails 3.

What it does:
-------------

1. Adds a route name (e.g. user_session) to every route.
2. Sorts the routes by url pattern and  method.
3. Sorts the params by key (e.g. action, controller)
4. Adds (.:format) to the url patterns of non-resource routes.

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

How I used rake_routes_normalizer:
----------------------------------

Running rake routes on an existing app can be slow. However, the routes are not dependent on your models and controllers, so you can test them in a fresh Rails 3 app. With this in mind, I created two dummy Rails 3 apps. The first contained my old routes commented out, while the second is where I intended to place the newer routes.

I then iterated through the routes: I uncommented each old route in the first dummy app and then wrote its equivalent in the second dummy app. With each iteration, I compared the `rake routes` printouts of the apps using meld. After I completed the routes, I copied the new routes to my working app.

The script I used to generate and compare the printouts was something like this:

    echo 'Getting dummy 2 routes...'
    cd dummy-2
    rake routes | rake_routes_normalizer > routes.txt

    cd ..

    echo 'Getting dummy 3 routes...'
    cd dummy-3
    rake routes | rake_routes_normalizer > routes.txt

    cd ..

    meld dummy-2/routes.txt dummy-3/routes.txt

Usage
=====

In a rails directory:

    rake routes | rake_routes_normalizer

Or if you saved the `rake routes` printout:

    rake_routes_normalizer rake_routes_printout.txt

Install
=======

    gem install rake_routes_normalizer


