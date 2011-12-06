require 'spec_helper'

describe RouteSet do
  describe "parse(text)" do
    it "can convert one line of text to a route set" do
      text = %q{root  /(.:format) {:action=>"default", :controller=>"pages"}}

      route_set = RouteSet.parse(text)
      route_set.routes.size.must_equal 1
    end
  end
end
