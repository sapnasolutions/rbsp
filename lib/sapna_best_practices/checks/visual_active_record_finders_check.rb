require 'sapna_best_practices/checks/check'

module SapnaBestPractices
  module Checks
    class VisualActiveRecordFindersCheck < SapnaBestPractices::Checks::Check
      
      def interesting_nodes
        [:call]
      end
      
      def interesting_files
        VIEW_AND_CONTROLLER_FILES
      end
      
      def evaluate_start(node)
        add_info "visually check model AR method '.#{node.message}'", node.file, node.subject.line if finder_method?(node)
      end
      
    private
      def finder_method?(node)
        node.message.to_s =~ Regexp.new(FINDER_METHOD_REG_EXPS.map{|x| "\\A#{x}\\Z" }.join("|"))
      end
      
    end
  end
end