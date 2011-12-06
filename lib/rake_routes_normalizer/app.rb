module RakeRoutesNormalizer
  class App < Thor
    desc "normalize text", "Print the normalized version of text"
    def normalize(text)
      puts RouteSet.parse(text).inspect #.normalize.to_s
    end
  end
end
