require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class CrossSiteRequestForgeryCheck < Check
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        CONTROLLER_FILES
      end
      
      def evaluate_start(node)
        add_error "Cross Site Request Forgery (CSRF)" unless csrf?(node)
      end

      private
      def csrf?(node)
        ret_val = nil
        if node.subject.to_s == "ApplicationController"
          ret_val = node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include? :protect_from_forgery
        else
          ret_val = check_skip_in_child(node)
        end
        return ret_val
      end

      def check_skip_in_child(node)
        child_nodes = node.grep_nodes({:node_type => :call}).select{|i| i.message==:skip_before_filter}
        child_arg_list = child_nodes[0].grep_nodes({:node_type => :arglist})[0].grep_nodes({:node_type => :lit}).collect{|i| i[1]}
        if(child_arg_list.blank?)
          return true
        else
          return (child_arg_list.include? :verify_authenticity_token) ? false : true
        end
      end
      
    end
  end
end