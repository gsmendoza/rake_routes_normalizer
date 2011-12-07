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

  describe "normalize(options)" do
    it "should return a copy of the route" do
      route = Route.new.tap do |route|
        route.name = 'root'
        route.http_verb = 'GET'
        route.url_pattern = '/(.:format)'
        route.params = {:action=>"default", :controller=>"pages"}
      end

      copy = route.normalize
      copy.must_be_instance_of Route
      copy.wont_be_same_as route
    end

    it "should set the http_verb to GET if it is blank" do
      route = Route.new(:http_verb => '')
      route.normalize.http_verb.must_equal 'GET'
    end

    it "should set the name to the options[:previous_route]'s name if it is blank" do
      previous_route = Route.new(:name => 'account_path')
      route = Route.new(:name => '')
      route.normalize(:previous_route => previous_route).name.must_equal 'account_path'
    end

    it "should set the name to '' if the name is blank and the route does not have previous route" do
      route = Route.new(:name => '')
      route.normalize(:previous_route => nil).name.must_equal ''
    end

    it "should sort the route's params by key" do
      route = Route.new(:params => {:controller=>"users", :action=>"edit_password", :protocol=>nil})
      route.normalize.params.inspect.must_equal %q|{"action"=>"edit_password", "controller"=>"users", "protocol"=>nil}|
    end

    it "should append (.:format) to the route if it is not specified" do
      route = Route.new(:url_pattern => "/jobs(/:job)")
      route.normalize.url_pattern.must_equal "/jobs(/:job)(.:format)"
    end

    it "should not append (.:format) to the route if it is specified" do
      route = Route.new(:url_pattern => "/account/edit_password(.:format)")
      route.normalize.url_pattern.must_equal "/account/edit_password(.:format)"
    end
  end

  describe "<=>(other)" do
    it "should sort the route and other's url_pattern" do
      routes = [
        Route.new(:url_pattern => '/account(.:format)',  :http_verb => 'GET'),
        Route.new(:url_pattern => '/airports(.:format)', :http_verb => 'GET')
      ]

      (routes[0] <=> routes[1]).must_be :<, 0
    end

    it "should compare the route and other's url_pattern by http_verb, if the url patterns are the same" do
      routes = [
        Route.new(:url_pattern => '/account(.:format)', :http_verb => 'GET'),
        Route.new(:url_pattern => '/account(.:format)', :http_verb => 'PUT')
      ]

      (routes[0] <=> routes[1]).must_be :<, 0
    end
  end
end
