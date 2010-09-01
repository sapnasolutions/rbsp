require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class FileParseRunner < SapnaBestPractices::Core::Runners::Runner

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


