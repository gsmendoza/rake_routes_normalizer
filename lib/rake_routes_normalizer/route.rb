module RakeRoutesNormalizer
  class Route
    LINE_REGEX = %r{ *([abcdefghijklmnopqrstuvwxyz_]*) +([ABCDEFGHIJKLMNOPQRSTUVWXYZ]*) +(\S+) +(.*)}
    attr_accessor :name, :http_verb, :url_pattern, :params

    def self.parse(line)
      new.tap do |result|
        tokens = line.match(LINE_REGEX)
        result.name = tokens[1]
        result.http_verb = tokens[2]
        result.url_pattern = tokens[3]
        result.params = eval(tokens[4])
      end
    end
  end
end
