module RakeRoutesNormalizer
  class RouteSet < Valuable
    has_collection :routes

    def self.parse(text)
      RouteSet.new.tap do |result|
        result.routes = text.split("\n").reject{|line| line =~ /^\s*$/}.map{|line| Route.parse(line)}
      end
    end

    def normalize
      result = routes.inject(RouteSet.new) do|route_set, route|
        previous_route = route_set.routes.detect{|r| route.url_pattern == r.url_pattern }
        route_set.routes << route.normalize(:previous_route => previous_route)
        route_set
      end
      result.routes.sort!
      result
    end
  end
end
