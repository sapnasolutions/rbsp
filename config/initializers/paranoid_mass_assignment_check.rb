require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class ParanoidMassAssignmentCheck < Check
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

      #This method will be required if the app is run as a web ap. If it is a gem and the checks are run once per execution,
      #then remove this method.
      #TODO Remove method when gemmed.
      def self.reinitialize
        @@paranoid_check = false
        @@temp_initializer_files = @@interested_initializer_files.dup
      end
      
      def initialize
        super
        @@paranoid_check = false
        @@temp_initializer_files = @@interested_initializer_files.dup
      end

      def evaluate_start(node)
        paranoid_assignment_check(node) unless @@paranoid_check
      end

      def update(filename)
        @@temp_initializer_files.delete(filename)
        model_files_hash = MassAssignmentCheck.model_files_hash
        if(!@@paranoid_check && @@temp_initializer_files.blank? && !model_files_hash.keys.blank?)
          model_files_prone_to_attack = []
          model_files_hash.each {|key, value| value==false ? (model_files_prone_to_attack << key) : nil}
          model_files_prone_to_attack.compact!
          model_files_prone_to_attack.each{|model_file|
            add_error "Mass assignment vulnerability for model: #{model_file} Please check: http://guides.rubyonrails.org/security.html#mass-assignment"
          }
          ParanoidMassAssignmentCheck.reinitialize
          MassAssignmentCheck.reinitialize
        end
      end

      def add_error(error, file = nil, line = nil)
        @errors << RailsBestPractices::Core::Error.new("", "", error)
      end

      def self.paranoid_check?
        @@paranoid_check
      end

      def self.paranoid_check=(state=false)
        @@paranoid_check = state
      end

      private

      def paranoid_assignment_check(node)
        if(node.message == :send)
          cn = node.grep_nodes({:node_type => :lit}).collect{|i| i[1]}
          @@paranoid_check = cn.include? :attr_accessible unless @@paranoid_check
        end
      end

    end
  end
end