require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class FilterParameterLoggingCheck < Check
      
      @@interested_ctrl_files = "./app/controllers/".map { |p|
                              if File.directory? p
                                Dir[File.join(p, '**', "*.rb")]
                              else
                                p
                              end
                            }.flatten
                            
      def interesting_nodes
        [:class]
      end
      
      def interesting_files
        CONTROLLER_FILES
      end
      
      def initialize
        super
        @@filter_parameter_log_check = false
        @@temp_ctrl_files = @@interested_ctrl_files.dup
      end
      
      def self.filter_parameter_log_check?
        @@filter_parameter_log_check
      end

      def self.filter_parameter_log_check=(state=false)
        @@filter_parameter_log_check = state
      end
      
      def evaluate_start(node)
        add_error "You have to filter certain request parameters(like password, credit card numbers,... etc) from your log." unless filter_parameter?(node)
      end
      
      
      private
      
      def filter_parameter?(node)
        if node.subject.to_s == "ApplicationController"
          @@filter_parameter_log_check = check_filter_parameter_in_node?(node)
          true
        else
          return_val = check_filter_parameter_in_node?(node)
          @@filter_parameter_log_check ? (@@temp_ctrl_files.delete(node.file); true) : (return_val ? (@@temp_ctrl_files.delete(node.file); true) : false)
        end
      end
      
      def check_filter_parameter_in_node?(node)
        node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include? :filter_parameter_logging
      end
      
    end
  end
end