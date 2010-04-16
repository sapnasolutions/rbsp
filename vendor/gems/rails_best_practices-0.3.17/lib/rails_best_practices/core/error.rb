module RailsBestPractices
  module Core
    class Error
      attr_reader :filename, :line_number, :message
      
      def initialize(filename, line_number, message)
        @filename = filename
        @line_number = line_number
        @message = message
      end
      
      def to_s
        unless @filename.blank?
          "#{@filename}:#{@line_number} - #{@message}"
        else
          "#{@message}"
        end
      end
    end
  end
end
