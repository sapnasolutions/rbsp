require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::FileParse::ErbScriptingAttackCheck do
  before(:each) do
    @runner = init_file_parse_runner(SapnaBestPractices::Checks::FileParse::ErbScriptingAttackCheck.new)
  end
  
  it "should warn of possible erb scripting attacks: no rails_xss plugin found" do
    run_file_parse_and_check_for_info(@runner, "app/views/foo.html.erb", view_content(true), ":2 - unsanitized Erb output (use <%=h ... %> where possible)")
  end

  # TODO
  # it "should not warn of possible erb scripting attacks: rails_xss plugin found" do
  # end
  
  def view_content(add_erb_output = false)
    <<-EOF
    This is a view file
    #{"<%= \"olaf polaf\"  %>" if add_erb_output}
    EOF
  end
  
end
