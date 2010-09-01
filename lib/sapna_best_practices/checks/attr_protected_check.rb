require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class AttrProtectedCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        MODLE_FILES
      end
      
      def evaluate_start(node)
        add_error "attr_protected is not advisable" if attr_protected_found?(node)
      end
      
    private
      def attr_protected_found?(node)
        node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include?(:attr_protected)
      end
      
    end
  end
end