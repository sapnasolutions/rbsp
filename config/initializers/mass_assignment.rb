require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class MassAssignment < Check
      INITIALIZER_FILES = /config\/initializers\/.*rb/

      @@interested_initializer_files = "./config/initializers/".map { |p|
                              if File.directory? p
                                Dir[File.join(p, '**', "*.rb")]
                              else
                                p
                              end
                            }.flatten

      @@interested_initializer_files << "./config/environment.rb"
      
      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        INITIALIZER_FILES
      end
      
      def initialize
        super
        @paranoid_check = false
         @interested_initializer_files = @@interested_initializer_files.dup
      end

      def evaluate_start(node)
        mass_assignment_proof?(node)
      end

      def update(filename)
        @interested_initializer_files.delete(filename)
        if !paranoid_check? && @interested_initializer_files.blank?
          $log.debug("=================== paranoid_check? : #{paranoid_check?} and @@interested_file: #{@interested_initializer_files.inspect}")
          add_error "Mass assignment vulnerability. Please check: http://guides.rubyonrails.org/security.html#mass-assignment"
          @paranoid_check = true
          @interested_initializer_files = @@interested_initializer_files.dup
        end
      end

      def add_error(error, file = nil, line = nil)
        @errors << RailsBestPractices::Core::Error.new("", "", error)
      end

      private
      def mass_assignment_proof?(node)
        paranoid_assignment(node)
      end

      def paranoid_assignment(node)
        if(node.message == :send)
          cn = node.grep_nodes({:node_type => :lit}).collect{|i| i[1]}
          @paranoid_check = cn.include? :attr_accessible unless @paranoid_check
        end
      end

      def paranoid_check?
        @paranoid_check
      end

    end
  end
end