require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::VisualAttrAccessibleCheck do
  before(:each) do
    @runner = init_single_runner(SapnaBestPractices::Checks::VisualAttrAccessibleCheck.new)
  end
  
  it "should warn of attr_accessible" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      attr_accessible :bar
    end
    EOF
    run_and_check_for_info(@runner, "app/models/foo.rb", content, ":1 - visually check attr_accessibles")
  end
  
  it "should not warn of attr_accessible" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/foo.rb", content)
  end
  
end
