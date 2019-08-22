module Metrc
  class Error < StandardError; end
  class ParameterMissing < Error; end
  class Unauthorized < Error; end
  class ShowErrorMessage < Error; end
  class UrlNotFound < Error; end
  class UnknownError < Error; end
end
