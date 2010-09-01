require 'sapna_best_practices/checks/grouped/check'

module SapnaBestPractices
  module Checks
    module Grouped
      class DisableMassAssignmentByDefaultCheck < SapnaBestPractices::Checks::Grouped::Check
      
        VALID_SEXP = Sexp.new(  :call, 
                                Sexp.new( :colon2, 
                                          Sexp.new(:const, :ActiveRecord), 
                                          :Base), 
                                :send, 
                                Sexp.new( :arglist, 
                                          Sexp.new(:lit, :attr_accessible), 
                                          Sexp.new(:nil)
                                )
                              )
      
        def error_message
          "mass assignment is not turned off by default (initialize it)"
        end
      
        def interesting_nodes
          [:call]
        end
      
        def interesting_files
          /config\/initializers\/(.*).rb$/
        end
      
        def evaluate_start(node)        
          @return_value ||= attr_accessible_turned_off?(node)
        end
      
      private
      
        def attr_accessible_turned_off?(node)
          return node == VALID_SEXP
        end
      
      end
    end
  end
end