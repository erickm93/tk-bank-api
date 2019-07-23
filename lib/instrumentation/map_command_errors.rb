module Instrumentation
  class MapCommandErrors
    def initialize(opts = {})
      @errors = opts.fetch(:errors, {})
    end

    def map_errors
      @errors.values.map(&:first)
    end
  end
end
