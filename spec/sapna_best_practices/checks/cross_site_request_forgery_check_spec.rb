require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::CrossSiteRequestForgeryCheck do
  before(:each) do
    @runner = SapnaBestPractices::Core::Runners::Runner.new(:single, SapnaBestPractices::Checks::CrossSiteRequestForgeryCheck.new)
  end
  
  it "should warn of CSRF in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
    end
    EOF
    run_and_check_for_error(@runner, "app/controllers/application.rb", content, ":1 - cross site request forgery (CSRF)")
  end
  
  it "should not warn of CSRF in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
      protect_from_forgery
    end
    EOF
    run_and_check_for_no_error(@runner, "app/controllers/application.rb", content)
  end
  
  it "should warn of CSRF in any other controller" do
    content = <<-EOF
    class FooController < ActionController::Base
      skip_before_filter :verify_authenticity_token
    end
    EOF
    run_and_check_for_error(@runner, "app/controllers/foo_controller.rb", content, ":1 - cross site request forgery (CSRF)")
  end

  it "should not warn of CSRF in any other controller" do
    content = <<-EOF
    class FooController < ActionController::Base
    end
    EOF
    run_and_check_for_no_error(@runner, "app/controllers/foo_controller.rb", content)
  end
  
end
