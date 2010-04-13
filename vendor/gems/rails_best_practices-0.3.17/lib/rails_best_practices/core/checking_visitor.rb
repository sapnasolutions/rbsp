require 'logger'
$log = Logger.new("#{RAILS_ROOT}/log/development.log")

module RailsBestPractices
  module Core
    class CheckingVisitor
      def initialize(*checks)
        @checks ||= {}
        checks.first.each do |check|
          nodes = check.interesting_nodes
          #$log.info "*********************************"
          #$log.debug nodes.inspect
          nodes.each do |node|
            @checks[node] ||= []
            @checks[node] << check
            @checks[node].uniq!
          end
        end
      end

    	def visit(node)
        checks = @checks[node.node_type]
        
        #checks.each {|check| check.evaluate_node_start(node) if node.file =~ check.interesting_files} unless checks.nil?
        unless checks.nil?
          checks.each do |check|
            $log.info "***********Node Loop*#{node.file}*************"
            $log.info "---------#{check.interesting_files.inspect}------------"
            check.evaluate_node_start(node) if node.file =~ check.interesting_files
          end
        end
        
    		node.visitable_children.each {|sexp| sexp.accept(self)}

        checks.each {|check| check.evaluate_node_end(node) if node.file =~ check.interesting_files} unless checks.nil?
    	end
    end
  end
end
