module RakeRoutesNormalizer
  class App < Thor
    desc "RAKE_PRINTOUT_FILE", "Print the normalized version of RAKE_PRINTOUT_FILE"
    def normalize(text)
      table = RouteSet.parse(text).normalize.routes.map do |route|
        [route.url_pattern, route.http_verb, route.name, route.params.inspect]
      end
      print_table table
    end
  end
end
