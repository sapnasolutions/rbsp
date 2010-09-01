require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class ErbScriptingAttackCheck < SapnaBestPractices::Checks::Check
      
        def interesting_tags
          [/\<\%\=(.*)\%\>/]
        end
      
        def interesting_files
          VIEW_FILES
        end
            
      end
    end
  end
end