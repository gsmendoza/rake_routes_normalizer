require 'spec_helper'

describe RouteSet do
  describe "parse(text)" do
    it "can convert one line of text to a route set" do
      text = %Q{root  /(.:format) {:action=>"default", :controller=>"pages"}}

      route_set = RouteSet.parse(text)
      route_set.routes.size.must_equal 1
    end

    it "should ignore blank lines" do
      text = %Q|root  /(.:format) {:action=>"default", :controller=>"pages"}\n   |

      route_set = RouteSet.parse(text)
      route_set.routes.size.must_equal 1
    end
  end

  describe "normalize" do
    it "should be a copy of the route set" do
      route_set = RouteSet.new.tap do |route_set|
        route_set.routes << Route.new.tap do |route|
          route.name = 'root'
          route.http_verb = 'GET'
          route.url_pattern = '/(.:format)'
          route.params = {:action=>"default", :controller=>"pages"}
        end
      end

      copy = route_set.normalize
      copy.must_be_instance_of RouteSet
      copy.wont_be_same_as route_set
      copy.routes.size.must_equal 1

      route = copy.routes[0]
      route.wont_be_same_as route_set.routes[0]
      route.name.must_equal 'root'
      route.http_verb.must_equal 'GET'
      route.url_pattern.must_equal '/(.:format)'
      route.params.inspect.must_equal %q|{"action"=>"default", "controller"=>"pages"}|
    end

    it "should normalize its route" do
      route_set = RouteSet.new.tap do |route_set|
        route_set.routes << Route.new.tap do |route|
          route.name = 'root'
          route.http_verb = ''
          route.url_pattern = '/(.:format)'
          route.params = {:action=>"default", :controller=>"pages"}
        end
      end

      route_set.normalize.routes[0].http_verb.must_equal "GET"
    end

    it "should normalize a route based the route's previous route" do
      route_set = RouteSet.new(
        :routes => [
          Route.new(:name => 'account', :url_pattern => '/account(.:format)'),
          Route.new(:name => '', :url_pattern => '/account(.:format)')
        ]
      )
      copy = route_set.normalize
      copy.routes.map(&:name).must_equal ['account', 'account']
    end

    it "should normalize a route based on a previous route even if the previous route if not adjacent to the current route" do
      route_set = RouteSet.new(
        :routes => [
          Route.new(:name => 'account', :http_verb => 'POST', :url_pattern => '/account(.:format)'),
          Route.new(:name => 'new_account', :http_verb => 'GET', :url_pattern => '/account/new(.:format)'),
          Route.new(:name => '', :http_verb => 'GET', :url_pattern => '/account(.:format)')
        ]
      )

      copy = route_set.normalize
      copy.routes.map(&:name).sort.must_equal ['account', 'account', 'new_account']
    end



    it "should sort the routes" do
      route_set = RouteSet.new(
        :routes => [
          Route.new(:url_pattern => '/airports(.:format)', :http_verb => 'GET'),
          Route.new(:url_pattern => '/account(.:format)',  :http_verb => 'GET')
        ]
      )
      copy = route_set.normalize
      copy.routes.map(&:url_pattern).uniq.must_equal ['/account(.:format)', '/airports(.:format)']
    end
  end
end
