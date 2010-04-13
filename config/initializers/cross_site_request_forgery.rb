require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class CrossSiteRequestForgery < Check
      
      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        /app\/controllers\/application_controller.rb/
      end
      
      def evaluate_start(node)
        @no_forgery = true
        $log.info "------------------------------"
        $log.debug node.inspect
        $log.debug node.class
        $log.debug node.message
        $log.debug node.body
        $log.debug node.file
        $log.debug node.node_type
        $log.info "------------------------------"
        
        if node.message == :protect_from_forgery
          @no_forgery = false
        end
        add_error "Cross Site Request Forgery (CSRF)" if @no_forgery
      end
      
      
    end
  end
end