require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::Grouped::ForgeryProtectionInTestCheck do
  before(:each) do    
    @runner = init_grouped_runner(SapnaBestPractices::Checks::Grouped::ForgeryProtectionInTestCheck.new)
    @runner.inversed = true
  end
  
  it "should warn of disabled forgery protection outside of test environment: development environment" do
    file_hashes = [
      {:filename => "config/environments/development.rb", :content => environment_content(true)},
      {:filename => "config/environments/production.rb" , :content => environment_content},
      {:filename => "config/environments/test.rb"       , :content => environment_content}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - forgery protection is turned off outside of test environment")
  end
  
  it "should warn of disabled forgery protection outside of test environment: production environment" do
    file_hashes = [
      {:filename => "config/environments/development.rb", :content => environment_content},
      {:filename => "config/environments/production.rb" , :content => environment_content(true)},
      {:filename => "config/environments/test.rb"       , :content => environment_content}
    ]    
    run_grouped_and_check_for_error(@runner, file_hashes, ": - forgery protection is turned off outside of test environment")
  end

  it "should not warn of disabled forgery protection outside of test environment" do
    file_hashes = [
      {:filename => "config/environments/development.rb", :content => environment_content},
      {:filename => "config/environments/production.rb" , :content => environment_content},
      {:filename => "config/environments/test.rb"       , :content => environment_content(true)}
    ]    
    run_grouped_and_check_for_no_error(@runner, file_hashes)
  end
  
  def environment_content(add_disabled_forgery_protection = false)
    <<-EOF
    config.foo = bar
    config.olaf = polaf
    #{"config.action_controller.allow_forgery_protection = false" if add_disabled_forgery_protection}
    EOF
  end

end
