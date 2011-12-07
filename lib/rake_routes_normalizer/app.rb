module RakeRoutesNormalizer
  class App < Thor
    desc "normalize [TEXT]", "Print the normalized version of text"
    def normalize(text)
      table = RouteSet.parse(text).normalize.routes.map do |route|
        [route.name, route.http_verb, route.url_pattern, route.params.inspect]
      end
      print_table table
    end
  end
end
