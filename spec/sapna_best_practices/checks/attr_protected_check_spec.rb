require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::AttrProtectedCheck do
  before(:each) do
    @runner = SapnaBestPractices::Core::Runners::Runner.new(:single, SapnaBestPractices::Checks::AttrProtectedCheck.new)
  end
  
  it "should warn of attr_protected" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      has_one :olaf
      attr_protected :bar
    end
    EOF
    @runner.check('app/models/foo.rb', content)
    errors = @runner.errors
    errors.should_not be_empty
    errors[0].to_s.should == "app/models/foo.rb:1 - attr_protected is not advisable"
  end
  
  it "should not warn of attr_protected" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      has_one :bar
    end
    EOF
    @runner.check('app/models/foo.rb', content)
    errors = @runner.errors
    errors.should be_empty
  end
  
end
