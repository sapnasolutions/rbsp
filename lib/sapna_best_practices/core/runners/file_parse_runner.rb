require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class FileParseRunner < SapnaBestPractices::Core::Runners::Runner

        def initialize(yaml_prefix, *checks)
          super
          # @config = File.exists?(CUSTOM_CONFIG) ? CUSTOM_CONFIG : DEFAULT_CONFIG
          # @checks = checks unless checks.empty?
          # @checks ||= load_checks(yaml_prefix)
          @checker = SapnaBestPractices::Core::FileParseCheckingVisitor.new(@checks)
        end
      
      # private
    
        # def load_checks
        #   check_objects = []
        #   checks = YAML.load_file @config
        #   checks["file_parse"].each do |check| 
        #     klass = eval("#{check[0]}")          
        #     check_objects << (check[1].empty? ? klass.new : klass.new(check[1])) 
        #   end
        #   check_objects
        # end
      
      end
    end
  end
end


