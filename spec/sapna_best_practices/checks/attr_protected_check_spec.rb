require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::AttrProtectedCheck do
  before(:each) do
    @runner = init_single_runner(SapnaBestPractices::Checks::AttrProtectedCheck.new)
  end
  
  it "should warn of attr_protected" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      attr_protected :bar
    end
    EOF
    run_and_check_for_error(@runner, "app/models/foo.rb", content, ":1 - attr_protected is not advisable")
  end
  
  it "should not warn of attr_protected" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
    end
    EOF
    run_and_check_for_no_error(@runner, "app/models/foo.rb", content)
  end
  
end
