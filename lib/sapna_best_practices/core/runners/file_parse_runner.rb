require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class FileParseRunner < SapnaBestPractices::Core::Runners::Runner
        
        def check_file(filename)
          @checker.check(filename)
        end
        
        def test_check_file(filename, lines)
          @checker.test_check(filename, lines)
        end
        
        def push_base_dir(base_dir)
          @checker.push_base_dir(base_dir)
        end

      end
    end
  end
end


