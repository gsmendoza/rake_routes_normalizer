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
        route_set.routes << route.normalize(:previous_route => route_set.routes.last)
        route_set
      end
      result.routes.sort!
      result
    end
  end
end
