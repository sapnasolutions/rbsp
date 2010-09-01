require 'sapna_best_practices/core/runners/runner'

module SapnaBestPractices
  module Core
    module Runners
      class FileParseRunner < SapnaBestPractices::Core::Runners::Runner

        def check_file(filename)
          @checker.check(filename)
        end

      end
    end
  end
end


