require 'spec_helper'

describe Route do
  describe "parse(text)" do
    it "can convert the text to a route set" do
      text = %q{root GET /(.:format) {:action=>"default", :controller=>"pages"}}

      route = Route.parse(text)
      route.name.must_equal 'root'
      route.http_verb.must_equal 'GET'
      route.url_pattern.must_equal '/(.:format)'
      route.params.must_equal({:action => "default", :controller => "pages"})
    end

    it "can convert the text if the text does not have an http verb" do
      text = %q{root  /(.:format) {:action=>"default", :controller=>"pages"}}

      route = Route.parse(text)
      route.name.must_equal 'root'
      route.http_verb.strip.must_equal ''
      route.url_pattern.must_equal '/(.:format)'
      route.params.must_equal({:action => "default", :controller => "pages"})
    end

    it "can convert the text if the text starts with spaces" do
      text = %q{  root GET /(.:format) {:controller=>"pages", :action=>"default"}}

      route = Route.parse(text)
      route.name.must_equal 'root'
      route.http_verb.must_equal 'GET'
      route.url_pattern.must_equal '/(.:format)'
      route.params.must_equal({:action => "default", :controller => "pages"})
    end

    it "can convert the text if the text does not have an name" do
      text = %q{  PUT    /account/change_password(.:format)  {:controller=>"users", :action=>"change_password"}}

      route = Route.parse(text)
      route.name.must_equal ''
      route.http_verb.must_equal 'PUT'
      route.url_pattern.must_equal '/account/change_password(.:format)'
      route.params.must_equal({:controller=>"users", :action=>"change_password"})
    end
  end
end
