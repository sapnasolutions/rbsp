require 'sapna_best_practices/checks/file_parse/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class EvalCheck < SapnaBestPractices::Checks::FileParse::Check
        
        def error_message
          "use of 'eval': check for safety"
        end
      
        def interesting_tags
          [/eval/]
        end
      
      end
    end
  end
end