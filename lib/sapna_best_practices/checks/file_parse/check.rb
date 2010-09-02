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
          content_has_tags?(file, get_lines(file))
        end
        
        def test_check(file, lines)
          content_has_tags?(file, lines)
        end
        
      private
      
        def get_lines(file)
          lines = []
          File.open(file, "r") do |f|
            while (line = f.gets)
              lines << line
            end
          end
          return lines
        end
      
        def content_has_tags?(filename, lines)
          lines.each_with_index do |line, idx|
            self.interesting_tags.each do |tag_regexp|
              add_info(error_message, filename, idx+1) if ((line =~ tag_regexp) >= 0)
            end
          end          
        end

      end
    end
  end
end