module RakeRoutesNormalizer
  class App < Thor
    default_task :normalize

    desc "normalize STDIN", "Print the normalized version of STDIN"
    def normalize
      puts "STDIN.read is #{STDIN.read}"
      # puts RouteSet.parse(STDIN.read).normalize.to_s
    end
  end
end
