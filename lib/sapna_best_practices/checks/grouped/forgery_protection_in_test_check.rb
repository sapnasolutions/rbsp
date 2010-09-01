require 'sapna_best_practices/checks/grouped/check'

module SapnaBestPractices
  module Checks
    module Grouped
      class ForgeryProtectionInTestCheck < SapnaBestPractices::Checks::Grouped::Check
      
        SEXP =  Sexp.new(
                  :attrasgn, 
                  Sexp.new( :call, 
                            Sexp.new( :call, 
                                      nil, 
                                      :config, 
                                      Sexp.new(:arglist)
                            ), 
                            :action_controller, 
                            Sexp.new(:arglist)
                  ), 
                  :allow_forgery_protection=, 
                  Sexp.new( :arglist, 
                            Sexp.new(:false)
                  )
                )
      
        def error_message
          "forgery protection is turned off outside of test environment"
        end
      
        def interesting_nodes
          [:attrasgn]
        end
      
        def interesting_files
          /config\/environments\/(.*).rb$/
        end
      
        def evaluate_start_attrasgn(node)
          @return_value ||= forgery_protection_found_outside_test_env?(node)
        end
        def evaluate_end_attrasgn(node); end
      
      private
      
        def forgery_protection_found_outside_test_env?(node)
          !(node.file.to_s =~ /test.rb/) && forgery_protection_found?(node)
        end
      
        def forgery_protection_found?(node)
          node == SEXP
        end
      
      end
    end
  end
end