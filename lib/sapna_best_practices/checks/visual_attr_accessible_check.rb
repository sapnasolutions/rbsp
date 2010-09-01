require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class VisualAttrAccessibleCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        MODLE_FILES
      end
      
      def evaluate_start(node)
        add_info "visually check attr_accessibles" if attr_accessible_found?(node)
      end
      
    private
      def attr_accessible_found?(node)
        node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include?(:attr_accessible)
      end
      
    end
  end
end