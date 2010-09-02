require 'sapna_best_practices/checks/file_parse/check'

module SapnaBestPractices
  module Checks
    module FileParse
      class ErbScriptingAttackCheck < SapnaBestPractices::Checks::FileParse::Check
        
        attr_accessor :base_dir

        PLUGIN_DIR = "/vendor/plugins/rails_xss"
        
        def error_message
          "unsanitized Erb output (use <%=h ... %> where possible)"
        end
      
        def interesting_tags
          [/\<\%\=[^h](.*)\%\>/]
        end
        
        def check(file)
          content_has_tags?(file, get_lines(file)) unless has_rails_xss_plugin?          
        end
        
      private
        # weak check for physical presence of the rails_xss plugin
        def has_rails_xss_plugin?          
          File.exists?(plugin = plugin_path) && File.directory?(plugin)
        end
        
        def plugin_path
          (@base_dir + PLUGIN_DIR).gsub("\/\/", "\/")
        end
      
      end
    end
  end
end