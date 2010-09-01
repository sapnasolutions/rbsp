require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class VisualCookiesCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        ALL_CONTROLLER_FILES
      end
      
      def evaluate_start(node)
        add_info "visually check getting and setting cookies (sensitive information?)" if cookies?(node)
      end
      
    private
      def cookies?(node)
        node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include?(:cookies)
      end
      
      
    end
  end
end