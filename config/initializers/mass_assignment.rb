require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class MassAssignment < Check
      INITIALIZER_FILES = /config\/initializers\/.*rb/

      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        INITIALIZER_FILES
      end
      
      def initialize
        super
      end

      def evaluate_start(node)
        add_error "Mass assignment vulnerability. Please check: http://guides.rubyonrails.org/security.html#mass-assignment" unless mass_assignment_proof?(node)
      end

      private
      def mass_assignment_proof?(node)
        if(node.message == :send)
          cn = node.grep_nodes({:node_type => :lit}).collect{|i| i[1]}
          cn.include? :attr_accessible
        else
          true
        end
      end

    end
  end
end