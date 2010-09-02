require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::Grouped::FilterParameterLoggingCheck do
  before(:each) do
    @runner = init_grouped_runner(SapnaBestPractices::Checks::Grouped::FilterParameterLoggingCheck.new)
  end
  
  it "should warn of filter parameter logging in application controller" do
    file_hashes = [
      {:filename => "app/controllers/application.rb", :content => controller_class_content("Application")}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - add filter parameter logging (to hide any sensitive information)")
  end

  it "should not warn of filter parameter logging in application controller" do
    file_hashes = [
      {:filename => "app/controllers/application.rb", :content => controller_class_content("Application", true)}
    ]    
    run_grouped_and_check_for_no_error(@runner, file_hashes)
  end

  it "should warn of filter parameter logging in any other controller" do
    file_hashes = [
      {:filename => "app/controllers/foo_controller.rb", :content => controller_class_content("Foo")},
      {:filename => "app/controllers/bar_controller.rb", :content => controller_class_content("Bar")},
      {:filename => "app/controllers/baz_controller.rb", :content => controller_class_content("Baz")}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - add filter parameter logging (to hide any sensitive information)")
  end
  
  it "should not warn of disabled mass assignment in any other controller" do
    file_hashes = [
      {:filename => "app/controllers/foo_controller.rb", :content => controller_class_content("Foo")},
      {:filename => "app/controllers/bar_controller.rb", :content => controller_class_content("Bar", true)},
      {:filename => "app/controllers/baz_controller.rb", :content => controller_class_content("Baz")}
    ]    
    run_grouped_and_check_for_no_error(@runner, file_hashes)
  end
  
  def controller_class_content(class_name, add_filter_parameter_logging = false)
    <<-EOF
    class #{class_name}Controller < ApplicationController
      #{ "filter_parameter_logging :bar\n" if add_filter_parameter_logging}      
      def foo
        # do something
      end
    end
    EOF
  end
  
end
