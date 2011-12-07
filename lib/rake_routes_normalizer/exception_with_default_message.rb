module RakeRoutesNormalizer
  class ExceptionWithDefaultMessage < Exception
    attr_reader :options
    def initialize(options={})
      @options = options
      message = options.is_a?(String) ?
        options :
        "#{self.class}. Got #{options.inspect}"
      super(message)
    end
  end
end
