require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class VisualNamedScopeConditionsCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        MODLE_FILES
      end
      
      def evaluate_start(node)
        add_info "visually check named_scope conditions", node.file, node.subject.line if conditional_named_scope_found?(node)
      end
      
    private
      def conditional_named_scope_found?(node)
        named_scope_found?(node) && conditional_found?(node)
      end
      
      def named_scope_found?(node)
        node.message.to_s =~ /named_scope/        
      end
      
      def conditional_found?(node)
        value = false
        node.children.each do |child|
          if child == Sexp.new(:lit, :conditions)
            value = true 
          else
            value ||= conditional_found?(child)
          end
        end if node
        return value
      end
      
    end
  end
end