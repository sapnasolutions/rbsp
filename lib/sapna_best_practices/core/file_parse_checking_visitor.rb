module SapnaBestPractices
  module Core
    class FileParseCheckingVisitor
      def initialize(checks)
        @checks ||= {}
        checks.each do |check|
          tags = check.interesting_tags
          tags.each do |tag|
            @checks[tag] ||= []
            @checks[tag] << check
            @checks[tag].uniq!
          end
        end
      end

    	def visit(tag)
        tags = @checks[tag]
        puts tags
    	end
    end
  end
end
