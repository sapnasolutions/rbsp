require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::Grouped::SessionResetCheck do
  before(:each) do
    @runner = init_grouped_runner(SapnaBestPractices::Checks::Grouped::SessionResetCheck.new)
  end
  
  it "should warn of unfound reset_session" do
    file_hashes = [
      {:filename => "app/controllers/foo_controller.rb", :content => controller_class_content("Foo")},
      {:filename => "app/controllers/bar_controller.rb", :content => controller_class_content("Bar")}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - session fixation: use reset_session after a successful login")
  end
  
  it "should not warn of unfound reset_session" do
    file_hashes = [
      {:filename => "app/controllers/foo_controller.rb", :content => controller_class_content("Foo")},
      {:filename => "app/controllers/bar_controller.rb", :content => controller_class_content("Bar", true)}
    ]    
    run_grouped_and_check_for_no_error(@runner, file_hashes)
  end
  
  def controller_class_content(class_name, add_reset_session = false)
    <<-EOF
    class #{class_name}Controller < ApplicationController
      def foo
        # do something
        #{"session_reset" if add_reset_session}
      end
    end
    EOF
  end
  
end
