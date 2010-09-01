require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class CrossSiteRequestForgeryCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        ALL_CONTROLLER_FILES
      end
      
      def evaluate_start(node)
        add_error "cross site request forgery (CSRF)" unless protected_from_forgery?(node)
      end
      
    private
      def protected_from_forgery?(node)
        (node.subject.to_s == "ApplicationController") ? 
          node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include?(:protect_from_forgery) :
          check_skip_authenticity_token_in_child(node)        
      end
      
      def check_skip_authenticity_token_in_child(node)
        child_nodes = node.grep_nodes({:node_type => :call}).select{|i| i.message == :skip_before_filter}
        child_arg_list = child_nodes[0].grep_nodes({:node_type => :arglist})[0].grep_nodes({:node_type => :lit}).collect{|i| i[1]}
        if child_arg_list.empty? 
          return true
        else
          return (child_arg_list.include?(:verify_authenticity_token)) ? false : true
        end
      end
      
    end
  end
end