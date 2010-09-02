require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::VisualActiveRecordFindersCheck do
  before(:each) do
    @runner = init_single_runner(SapnaBestPractices::Checks::VisualActiveRecordFindersCheck.new)
  end
  
  SapnaBestPractices::Checks::Check::FINDER_METHOD_REG_EXPS.each do |regexp_string|
    regexp_string_method = regexp_string.gsub("(.*)", "olaf")
    it "should warn of AR finder methods in controllers: .#{regexp_string}" do
      content = <<-EOF
      class FooController < ApplicationController
        def bar
          Baz.#{regexp_string_method}
        end
      end
      EOF
      run_and_check_for_info(@runner, "app/controllers/foo_controller.rb", content, ":3 - visually check model AR method '.#{regexp_string_method}'")
    end
  end
  
  it "should not warn of AR finder methods in controllers" do
    content = <<-EOF
    class FooController < ApplicationController
    end
    EOF
    run_and_check_for_no_info(@runner, "app/controllers/foo_controller.rb", content)
  end
  
  
  
  SapnaBestPractices::Checks::Check::FINDER_METHOD_REG_EXPS.each do |regexp_string|
    regexp_string_method = regexp_string.gsub("(.*)", "olaf")
    it "should warn of AR finder methods in models: .#{regexp_string}" do
      content = <<-EOF
      class Foo < ActiveRecord::Base
        def bar
          Baz.#{regexp_string_method}
        end
      end
      EOF
      run_and_check_for_info(@runner, "app/models/foo.rb", content, ":3 - visually check model AR method '.#{regexp_string_method}'")
    end
  end
  
  it "should not warn of AR finder methods in models" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/foo.rb", content)
  end



  SapnaBestPractices::Checks::Check::FINDER_METHOD_REG_EXPS.each do |regexp_string|
    regexp_string_method = regexp_string.gsub("(.*)", "olaf")
    it "should warn of AR finder methods in libs: .#{regexp_string}" do
      content = <<-EOF
      class Foo 
        def bar
          Baz.#{regexp_string_method}
        end
      end
      EOF
      run_and_check_for_info(@runner, "lib/foo.rb", content, ":3 - visually check model AR method '.#{regexp_string_method}'")
    end
  end
  
  it "should not warn of AR finder methods in libs" do
    content = <<-EOF
    class Foo
    end
    EOF
    run_and_check_for_no_info(@runner, "lib/foo.rb", content)
  end

  
end
