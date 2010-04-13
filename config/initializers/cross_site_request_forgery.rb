require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class CrossSiteRequestForgery < Check
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
        node.grep_nodes({:node_type => :call}).collect{|i| i[2]}.include? :protect_from_forgery
      end
    end
  end
end