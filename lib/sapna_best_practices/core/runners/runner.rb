require 'rails_best_practices/core/checking_visitor'

module SapnaBestPractices
  module Core
    module Runners
      class Runner < RailsBestPractices::Core::Runner
        DEFAULT_CONFIG = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "sapna_best_practices.yml")
        CUSTOM_CONFIG = File.join('config', 'sapna_best_practices.yml')
      
        attr_accessor :inversed
      
        def initialize(yaml_prefix, *checks)
          @inversed = false
          @config = File.exists?(CUSTOM_CONFIG) ? CUSTOM_CONFIG : DEFAULT_CONFIG
          @checks = checks unless checks.empty?
          @checks ||= load_checks(yaml_prefix)
          @checker ||= RailsBestPractices::Core::CheckingVisitor.new(@checks)
          @debug = false
        end
      
        # infos only exist on sapna best practices checks
        # not on the rails best practices, so rescue the mofo!
        def infos
          @checks ||= []
          return @checks.collect do |check| 
            begin
              check.infos 
            rescue NoMethodError
              []
            end
          end.flatten
        end
      
        def get_node(filename, content)
          if filename =~ /.*\.erb/
            content = ERB.new(content).src
          end
          if filename =~ /.*\.haml/
            require 'haml'
            content = Haml::Engine.new(content).precompiled
            # remove \xxx characters
            content.gsub!(/\\\d{3}/, '')
          end
          node = parse(filename, content)
        end
      
      private 
      
        def load_checks(yaml_prefix)
          check_objects = []
          checks = YAML.load_file @config          
          checks[yaml_prefix.to_s].each do |check| 
            klass = eval("#{check[0]}")          
            # check_objects << (check[1].empty? ? klass.new : klass.new(check[1])) 
          
            if check[1].empty?
              check_objects << klass.new
            else
              if check[1].keys.first == "inversed"
                check_objects << klass.new
                @inversed = (check[1].values.last == true)
              else
                check_objects << klass.new(check[1])
              end
            end

          end
          check_objects
        end      
      
      end
    end
  end
end