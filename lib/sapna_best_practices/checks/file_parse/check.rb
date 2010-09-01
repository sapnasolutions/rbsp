require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class Check < SapnaBestPractices::Checks::Check
        
        def error_message
          # OVERRIDE THIS
          ""
        end
        
        def interesting_tags
          # OVERRIDE THIS
          []
        end
      
        def interesting_files
          # OVERRIDE THIS
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
                add_error(error_message, file, line_count) if ((line =~ tag_regexp) >= 0)
              end
            end
          end
        end
            
      end
    end
  end
end