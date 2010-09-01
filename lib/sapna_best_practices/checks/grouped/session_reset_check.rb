require 'sapna_best_practices/checks/grouped/check'

module SapnaBestPractices
  module Checks
    module Grouped
      class SessionResetCheck < SapnaBestPractices::Checks::Grouped::Check
      
        def error_message
          "session fixation: use reset_session after a successful login"
        end
      
        def interesting_nodes
          [:class]
        end
      
        def interesting_files
          CONTROLLER_FILES
        end
      
        def evaluate_start(node)        
          @return_value ||= session_reset_after_login?(node)
        end
      
      private
      
        def session_reset_after_login?(node)
          node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include? :session_reset
        end
      
      end
    end
  end
end