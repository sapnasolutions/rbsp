require 'rails_best_practices/checks/check'
require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Checks
    
    class SessionFixationCheck < Check
       
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
        @@reset_pwd_check = false
        @@temp_ctrl_files = @@interested_ctrl_files.dup
      end
      
      def self.reinitialize
        @@reset_pwd_check = false
        @@temp_ctrl_files = @@interested_ctrl_files.dup
      end
      
      def self.reset_pwd_check?
        @@reset_pwd_check
      end

      def self.reset_pwd_check=(state=false)
        @@reset_pwd_check = state
      end
      
      def evaluate_start(node)
        session_fixation_check?(node)
      end
      
      def update(filename)
        if @@temp_ctrl_files.empty? && !@@reset_pwd_check
          add_error "Session Fixation: You have to use reset_session after a successful login..."
          SessionFixationCheck.reinitialize
        end
      end
      
      private
      
      def session_fixation_check?(node)
        unless node.grep_nodes({:node_type => :call}).blank?
          return_val = node.grep_nodes({:node_type => :call}).collect{|i| i.message}.include? :reset_session
          @@reset_pwd_check = return_val if (!@@reset_pwd_check && return_val)
        end
        @@temp_ctrl_files.delete(node.file)
      end
      
      def add_error(error, file = nil, line = nil)
        @errors << RailsBestPractices::Core::Error.new("", "", error)
      end
      
    end
  end
end