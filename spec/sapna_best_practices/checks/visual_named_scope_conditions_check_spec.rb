require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe SapnaBestPractices::Checks::VisualNamedScopeConditionsCheck do
  before(:each) do
    @runner = init_single_runner(SapnaBestPractices::Checks::VisualNamedScopeConditionsCheck.new)
  end
  
  it "should warn of named_scope with conditions" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      named_scope :name, :joins => :table, :conditions => ['field = ?', true]
    end
    EOF
    run_and_check_for_info(@runner, "app/models/foo.rb", content, ":3 - visually check named_scope conditions")
  end

  it "should not warn of named_scope without conditions" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
      named_scope :name, :joins => :table
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/foo.rb", content)
  end
  
  it "should not warn of named_scope" do
    content = <<-EOF
    class Foo < ActiveRecord::Base
    end
    EOF
    run_and_check_for_no_info(@runner, "app/models/foo.rb", content)
  end
  
end
