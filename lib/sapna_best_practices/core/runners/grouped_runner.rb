require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class GroupedRunner < SapnaBestPractices::Core::Runners::Runner

        def check_files(files)
          @checks.each do |check|
            checker = RailsBestPractices::Core::CheckingVisitor.new([check])

            filtered_files = filter_files(files, check.interesting_files)          
            filtered_files.each do |filtered_file|
              node = get_node(filtered_file, File.read(filtered_file))
              node.accept(checker) if node
            end

            add_error(check)
          end
        end
      
        def add_error(check)
          if @inversed
            check.add_error check.error_message, "", "" if check.return_value
          else
            check.add_error check.error_message, "", "" unless check.return_value
          end
        end
        
        def run(files)
          self.check_files(files)          
        end
      
      private
    
        def filter_files(files, filter_regexp)
          return files.select{|x| x =~ filter_regexp }        
        end
      
      end
    end
  end
end


