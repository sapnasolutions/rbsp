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
    @runner.check('app/controllers/application.rb', content)
    errors = @runner.errors
    errors.should_not be_empty
    errors[0].to_s.should == "app/controllers/application.rb:1 - cross site request forgery (CSRF)"
  end
  
  it "should not warn of CSRF in application controller" do
    content = <<-EOF
    class ApplicationController < ActionController::Base
      protect_from_forgery
    end
    EOF
    @runner.check('app/controllers/application.rb', content)
    errors = @runner.errors
    errors.should be_empty
  end
  
  it "should warn of CSRF in any other controller" do
    content = <<-EOF
    class FooController < ActionController::Base
      skip_before_filter :verify_authenticity_token
    end
    EOF
    @runner.check('app/controllers/foo_controller.rb', content)
    errors = @runner.errors
    errors.should_not be_empty
    errors[0].to_s.should == "app/controllers/foo_controller.rb:1 - cross site request forgery (CSRF)"
  end

  it "should not warn of CSRF in any other controller" do
    content = <<-EOF
    class FooController < ActionController::Base
    end
    EOF
    @runner.check('app/controllers/foo_controller.rb', content)
    errors = @runner.errors
    errors.should be_empty
  end
  
end
