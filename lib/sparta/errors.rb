module Sparta
  class UnpermittedParameter < StandardError
    def initialize(param)
      super "#{param} is not permitted"
    end
  end

  class MissingRequiredParameter < StandardError; end
end
