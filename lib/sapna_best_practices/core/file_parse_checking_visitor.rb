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
    	
    	def test_check(filename, lines)
    	  @checks.each do |check|
    	    if filename =~ check.interesting_files
    	      check.test_check(filename, lines)
  	      end
  	    end
  	  end
    end
  end
end
