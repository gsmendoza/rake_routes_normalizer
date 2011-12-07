module RakeRoutesNormalizer
  class Route < Valuable
    LINE_REGEX = %r{ *([abcdefghijklmnopqrstuvwxyz_]*) +([ABCDEFGHIJKLMNOPQRSTUVWXYZ]*) +(\S+) +(.*)}

    has_value :http_verb
    has_value :name
    has_value :params
    has_value :url_pattern

    def self.parse(line)
      new.tap do |result|
        tokens = line.match(LINE_REGEX)
        result.name = tokens[1]
        result.http_verb = tokens[2]
        result.url_pattern = tokens[3]
        result.params = eval(tokens[4])
      end
    rescue NoMethodError => e
      raise CannotParseLine.new(:line => line)
    end

    def <=>(other)
      [:url_pattern, :http_verb].inject(0) do |result, attribute|
        result == 0 ? (self.send(attribute) || '') <=> (other.send(attribute) || '') : result
      end
    end

    def normalize(options = {})
      clone.tap do |result|
        result.http_verb = 'GET' if result.http_verb.to_s =~ /^\s*$/
        result.name = options[:previous_route].name if result.name =~ /^\s*$/
        result.params = Dictionary[KeyHash[params || {}]].order_by_key
      end
    end

    class CannotParseLine < ExceptionWithDefaultMessage
    end
  end
end
