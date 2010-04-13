# RbpFu
require 'rails_best_practices/core/error'

module RailsBestPractices
  module Checks
    class Check
      alias_method :old_add_error, :add_error
      def add_error(error, line = nil)
        old_add_error(error, line)
        actual_err = @errors[@errors.length-1].to_s
        RbpError.create({:error => actual_err, :rbp_run_id => self.run_id})
      end

      def self.run_id=(run_id)
        @@run_id = run_id
      end

      def self.run_id
        @@run_id
      end
    end
  end
end
