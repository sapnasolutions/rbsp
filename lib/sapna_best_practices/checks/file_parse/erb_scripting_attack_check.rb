require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class ErbScriptingAttackCheck < SapnaBestPractices::Checks::Check
        
        ERROR_MESSAGE = "unsanitized Erb output (use <%=h ... %> where possible)"
      
        def interesting_tags
          [/\<\%\=[^h](.*)\%\>/]
        end
      
        def interesting_files
          VIEW_FILES
        end
        
        def check(file)
          content_has_tags?(file)
        end
        
      private
      
        def content_has_tags?(file)
          line_count = 0
          File.open(file, "r") do |f|
            while (line = f.gets)
              line_count = line_count + 1
              self.interesting_tags.each do |tag_regexp|
                add_error(ERROR_MESSAGE, file, line_count) if ((line =~ tag_regexp) >= 0)
              end
            end
          end
        end
            
      end
    end
  end
end