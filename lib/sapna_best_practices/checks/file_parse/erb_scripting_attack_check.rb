require 'sapna_best_practices/checks/file_parse/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class ErbScriptingAttackCheck < SapnaBestPractices::Checks::FileParse::Check
        
        def error_message
          "unsanitized Erb output (use <%=h ... %> where possible)"
        end
      
        def interesting_tags
          [/\<\%\=[^h](.*)\%\>/]
        end
      
      end
    end
  end
end