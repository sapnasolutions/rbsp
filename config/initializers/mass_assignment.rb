require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class MassAssignment < Check
      INITIALIZER_FILES = /config\/initializers\/.*rb/

      def interesting_nodes
        [:attrasgn]
      end
      
      def interesting_files
        INITIALIZER_FILES
      end
      
      def evaluate_start(node)
        add_error "Mass assignment vulnerability. Visit: http://guides.rubyonrails.org/security.html#mass-assignment" unless mass_assignment_proof?(node)
      end

      private
      def mass_assignment_proof?(node)
        $log.debug("In mass assignment proof : #{node.file}")
      end
      
    end
  end
end