module RakeRoutesNormalizer
  class RouteSet
    attr_accessor :routes

    def self.parse(text)
      RouteSet.new.tap do |result|
        result.routes = text.split("\n").map{|line| Route.parse(line)}
      end
    end
  end
end
