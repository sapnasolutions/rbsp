module SapnaBestPractices
  module Core
    class FileParseCheckingVisitor
      def initialize(checks)
        @checks = checks
      end

    	def check(file)
    	  @checks.each do |check|
    	    if file =~ check.interesting_files
    	      check.check(file)
  	      end
  	    end
    	end
    end
  end
end
