require 'sapna_best_practices/checks/grouped/check'

module SapnaBestPractices
  module Checks
    module Grouped
      class FilterParameterLoggingCheck < SapnaBestPractices::Checks::Grouped::Check
      
        def error_message
          "add filter parameter logging (to hide any sensitive information)"
        end
      
        def interesting_nodes
          [:class]
        end
      
        def interesting_files
          ALL_CONTROLLER_FILES
        end
      
        def evaluate_start(node)        
          @return_value ||= logs_filtered?(node)
        end
      
      private
      
        def logs_filtered?(node)
          node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include? :filter_parameter_logging
        end
      
      end
    end
  end
end