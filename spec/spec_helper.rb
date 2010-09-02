require 'rubygems'
require 'spec/autorun'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'rails_best_practices'
require 'sapna_best_practices'

def run_and_check_for_error(runner, filename, content, message_prefix)
  runner.check(filename, content)  
  (errors = runner.errors).should_not be_empty
  errors[0].to_s.should == "#{filename}#{message_prefix}"
end

def run_and_check_for_no_error(runner, filename, content)
  runner.check(filename, content)
  runner.errors.should be_empty
end