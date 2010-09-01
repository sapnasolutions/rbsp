require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class EvalCheck < SapnaBestPractices::Checks::Check
      
      # TODO: error shows up twice!
      #       once for the :class node AND
      #       once for the :module node (see any helper module)
      def interesting_nodes
        [:module, :class]
      end
      
      def interesting_files
        /[^views\/.*\.(erb|haml)]/
      end
      
      def evaluate_start(node)
        add_error "use of 'eval': check for safety" if eval_found?(node)
      end
      def evaluate_start_module(node)
        add_error "use of 'eval': check for safety" if eval_found?(node)
      end
      def evaluate_end_module(node); end
      
    private
      def eval_found?(node)
        node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include?(:eval)
      end
      
    end
  end
end