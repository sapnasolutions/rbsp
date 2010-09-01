require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    module Grouped
      class Check < SapnaBestPractices::Checks::Check
      
        attr_reader :return_value
      
        def initialize
          super
          @return_value = false
        end
      
      end
    end
  end
end