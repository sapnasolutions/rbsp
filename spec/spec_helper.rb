require 'rubygems'
require 'spec/autorun'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'rails_best_practices'
require 'sapna_best_practices'

def init_single_runner(check)
  SapnaBestPractices::Core::Runners::Runner.new(:single, check)
end

def init_grouped_runner(check)
  SapnaBestPractices::Core::Runners::GroupedRunner.new(:grouped, check)
end

def init_file_parse_runner(check)
  SapnaBestPractices::Core::Runners::FileParseRunner.new(:file_parse, check)
end


def run_and_check_for_error(runner, filename, content, message_prefix)
  runner.check(filename, content)  
  (errors = runner.errors).should_not be_empty
  errors[0].to_s.should == "#{filename}#{message_prefix}"
end

def run_and_check_for_info(runner, filename, content, message_prefix)
  runner.check(filename, content)  
  (infos = runner.infos).should_not be_empty
  infos[0].to_s.should == "#{filename}#{message_prefix}"
end

def run_and_check_for_no_error(runner, filename, content)
  runner.check(filename, content)
  runner.errors.should be_empty
end

def run_and_check_for_no_info(runner, filename, content)
  runner.check(filename, content)
  runner.infos.should be_empty
end


def run_grouped_and_check_for_error(runner, file_hash, message)
  runner.check_files(file_hash)
  (errors = runner.errors).should_not be_empty
  errors[0].to_s.should == message
end

def run_grouped_and_check_for_no_error(runner, file_hash)
  runner.check_files(file_hash)
  runner.errors.should be_empty
end


def run_file_parse_and_check_for_info(runner, filename, content, message_prefix)
  runner.test_check_file(filename, content.split("\n"))
  (infos = runner.infos).should_not be_empty
  infos[0].to_s.should == "#{filename}#{message_prefix}"
end

def run_file_parse_and_check_for_no_info(runner, filename, content)
  runner.test_check_file(filename, content)
  runner.infos.should be_empty
end