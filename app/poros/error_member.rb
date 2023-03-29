class ErrorMember
  attr_reader :error_message,
              :status,
              :code
  def initialize(message, status, code)
    @error_message = message
    @status = status
    @code = code
  end
end