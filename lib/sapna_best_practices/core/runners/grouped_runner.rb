require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class GroupedRunner < SapnaBestPractices::Core::Runners::Runner

        def check_files(file_hashes)          
          @checks.each do |check|
            checker = RailsBestPractices::Core::CheckingVisitor.new([check])

            filtered_file_hashes = filter_files(file_hashes, check.interesting_files)          

            filtered_file_hashes.each do |filtered_file_hash|
              node = get_node(filtered_file_hash[:filename], filtered_file_hash[:content])
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
          self.check_files(read_in_files(files))          
          display_error_messages
          display_info_messages
        end
      
      private
      
        def read_in_files(files)
          return files.map{|x| { :filename => x, :content => File.read(x) } }
        end
    
        def filter_files(file_hashes, filter_regexp)
          return file_hashes.select{ |x| x[:filename] =~ filter_regexp }
        end
      
      end
    end
  end
end


