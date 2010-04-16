require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class MassAssignmentCheck < Check

      @@interested_model_files = "./app/models/".map { |p|
                              if File.directory? p
                                Dir[File.join(p, '**', "*.rb")]
                              else
                                p
                              end
                            }.flatten

      @@model_files_hash = {}
      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        MODLE_FILES
      end
      
      def initialize
        super
        @@temp_model_files = @@interested_model_files.dup
        @@interested_model_files.each {|i| @@model_files_hash[i] = false}
      end

      def self.reinitialize
        @@temp_model_files = @@interested_model_files.dup
        @@interested_model_files.each {|i| @@model_files_hash[i] = false}
      end

      def evaluate_start(node)
        #Dont have to evaluate nodes if the paronoid check is already in place
        mass_assignment_proof_check(node) unless ParanoidMassAssignmentCheck.paranoid_check?
      end

      def update(filename)
        @@temp_model_files.delete(filename)
      end

      def self.temp_model_files
        @@temp_model_files
      end

      def self.interested_model_files
        @@interested_model_files
      end

      def self.model_files_hash
        @@model_files_hash
      end

      private
      def mass_assignment_proof_check(node)
        if(node.message == :attr_accessible || node.message == :attr_protected)
          @@model_files_hash[node.file] = true
        end
      end

    end
  end
end