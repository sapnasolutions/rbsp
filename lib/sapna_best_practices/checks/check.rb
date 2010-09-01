require 'rails_best_practices/checks/check'
require 'sapna_best_practices/core/info'

module SapnaBestPractices
  module Checks
    class Check < RailsBestPractices::Checks::Check
      
      VIEW_AND_CONTROLLER_FILES = /[_controller\.rb$|views\/.*\.(erb|haml)]/
      ALL_CONTROLLER_FILES = /_controller\.rb$|application.rb$/
      
      attr_reader :infos
      
      def initialize
        super
        @infos = []
      end
      
      def add_info(info, file = nil, line = nil)
        file ||= @node.file
        line ||= @node.line
        @infos << SapnaBestPractices::Core::Info.new("#{file}", "#{line}", info)
      end
      
    end
  end
end
