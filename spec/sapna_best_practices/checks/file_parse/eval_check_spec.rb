require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::FileParse::EvalCheck do
  before(:each) do
    @runner = init_file_parse_runner(SapnaBestPractices::Checks::FileParse::EvalCheck.new)
  end
  
  it "should warn of 'eval' use" do
    run_file_parse_and_check_for_info(@runner, "app/views/foo.html.erb", view_content(true), ":2 - use of 'eval': check for safety")
  end

  it "should not warn of 'eval' use" do
    run_file_parse_and_check_for_no_info(@runner, "app/views/foo.html.erb", view_content)
  end
  
  def view_content(add_eval = false)
    <<-EOF
    This is a view file
    #{"<% olaf = eval(\"polaf\") %>" if add_eval}
    EOF
  end
  
end
