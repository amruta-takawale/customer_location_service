# frozen_string_literal: true

module Processor
  module Error
    class ProcessorError < RuntimeError; end
    class UserIdNotPresent < ProcessorError; end
    class UserNameNotPresent < ProcessorError; end
    class UserlatNotPresent < ProcessorError; end
    class UserlngNotPresent < ProcessorError; end
    class InvalidDataType < ProcessorError; end
    class OutofRange < ProcessorError; end
  end
end
