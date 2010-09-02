require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::VisualCookiesCheck do
  before(:each) do
    @runner = init_single_runner(SapnaBestPractices::Checks::VisualCookiesCheck.new)
  end
  
  it "should warn of setting cookies in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
      def bar
        cookies[:olaf] = :polaf
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/controllers/application.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end

  it "should warn of getting cookies in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
      def bar
        return cookies[:olaf] + 1
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/controllers/application.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end
  
  it "should not warn of cookies in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/application.rb", content)
  end


  it "should warn of setting cookies in any other controller" do
    content = <<-EOF
    class FooController < ApplicationController
      def bar
        cookies[:olaf] = :polaf
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/controllers/foo_controller.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end

  it "should warn of getting cookies in any other controller" do
    content = <<-EOF
    class FooController < ApplicationController
      def bar
        return cookies[:olaf] + 1
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/controllers/foo_controller.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end
  
  it "should not warn of cookies in any other controller" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/foo_controller.rb", content)
  end


  it "should warn of setting cookies in helpers" do
    content = <<-EOF
    module FooHelper
      def bar
        cookies[:olaf] = :polaf
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/helpers/foo_helper.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end

  it "should warn of getting cookies in helpers" do
    content = <<-EOF
    module FooHelper
      def bar
        return cookies[:olaf] + 1
      end
    end
    EOF
    run_and_check_for_info(@runner, "app/helpers/foo_helper.rb", content, ":1 - visually check getting and setting cookies (sensitive information?)")
  end
  
  it "should not warn of cookies in helpers" do
    content = <<-EOF
    module FooHelper
    end
    EOF
    run_and_check_for_no_info(@runner, "app/helpers/foo_helper.rb", content)
  end
  
end
