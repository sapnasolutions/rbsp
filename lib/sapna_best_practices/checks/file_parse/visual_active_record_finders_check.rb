require 'sapna_best_practices/checks/file_parse/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class VisualActiveRecordFindersCheck < SapnaBestPractices::Checks::FileParse::Check
        
        def error_message
          "visually check model AR method"
        end
      
        def interesting_tags
          FINDER_METHOD_REG_EXPS.map{|x| Regexp.new("\\.#{x}") }
        end
            
      end
    end
  end
end