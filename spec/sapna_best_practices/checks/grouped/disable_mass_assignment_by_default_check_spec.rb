require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::Grouped::DisableMassAssignmentByDefaultCheck do
  before(:each) do
    @runner = init_grouped_runner(SapnaBestPractices::Checks::Grouped::DisableMassAssignmentByDefaultCheck.new)
  end
  
  it "should warn of disabled mass assignment" do
    file_hashes = [
      {:filename => "config/initializers/foo.rb", :content => ""},
      {:filename => "config/initializers/bar.rb", :content => ""},
      {:filename => "config/initializers/baz.rb", :content => ""}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - mass assignment is not turned off by default (initialize it)")
  end
  
  it "should not warn of disabled mass assignment" do
    file_hashes = [
      {:filename => "config/initializers/foo.rb", :content => "ActiveRecord::Base.send(:attr_accessible, nil)"},
      {:filename => "config/initializers/bar.rb", :content => ""},
      {:filename => "config/initializers/baz.rb", :content => ""}
    ]    
    run_grouped_and_check_for_no_error(@runner, file_hashes)
  end
  
end
