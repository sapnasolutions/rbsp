require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::EvalCheck do
  before(:each) do
    @runner = SapnaBestPractices::Core::Runners::Runner.new(:single, SapnaBestPractices::Checks::EvalCheck.new)
  end
  
  it "should warn of eval in helpers" do
    content = <<-EOF
    module FooHelper
      eval('foo bar baz')
    end
    EOF
    run_and_check_for_error(@runner, "app/helpers/foo_helper.rb", content, ":1 - use of 'eval': check for safety")
  end

  it "should not warn of eval in helpers" do
    content = <<-EOF
    module FooHelper
    end
    EOF
    run_and_check_for_no_error(@runner, "app/helpers/foo_helper.rb", content)
  end

  it "should warn of eval in controllers" do
    content = <<-EOF
    class FooController < ApplicationController
      def bar
        eval('foo bar baz')
      end
    end
    EOF
    run_and_check_for_error(@runner, "app/controllers/foo_controller.rb", content, ":1 - use of 'eval': check for safety")
  end

  it "should not warn of eval in controllers" do
    content = <<-EOF
    class FooController < ApplicationController
      def bar
      end
    end
    EOF
    run_and_check_for_no_error(@runner, "app/controllers/foo_controller.rb", content)
  end
  
  it "should warn of eval in models" do
    content = <<-EOF
    class FooController < ActiveRecord::Base
      def bar
        eval('foo bar baz')
      end
    end
    EOF
    run_and_check_for_error(@runner, "app/models/foo.rb", content, ":1 - use of 'eval': check for safety")
  end

  it "should not warn of eval in models" do
    content = <<-EOF
    class FooController < ActiveRecord::Base
      def bar
      end
    end
    EOF
    run_and_check_for_no_error(@runner, "app/models/foo.rb", content)
  end
  
  it "should warn of eval in libs" do
    content = <<-EOF
    class Foo
      def bar
        eval('foo bar baz')
      end
    end
    EOF
    run_and_check_for_error(@runner, "lib/foo.rb", content, ":1 - use of 'eval': check for safety")
  end

  it "should not warn of eval in libs" do
    content = <<-EOF
    class Foo
      def bar
      end
    end
    EOF
    run_and_check_for_no_error(@runner, "lib/foo.rb", content)
  end
  
end
