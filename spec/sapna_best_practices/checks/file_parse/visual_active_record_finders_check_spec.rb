require File.join(File.dirname(__FILE__) + '/../../../spec_helper')

describe SapnaBestPractices::Checks::FileParse::VisualActiveRecordFindersCheck do
  before(:each) do
    @runner = init_file_parse_runner(SapnaBestPractices::Checks::FileParse::VisualActiveRecordFindersCheck.new)
  end
  
  SapnaBestPractices::Checks::Check::FINDER_METHOD_REG_EXPS.each do |regexp_string|
    regexp_string_method = regexp_string.gsub("(.*)", "olaf")
    it "should warn of AR finder methods: .#{regexp_string}" do
      run_file_parse_and_check_for_info(@runner, "app/views/foo.html.erb", view_content(true, regexp_string), ":2 - visually check model AR method")
    end
  end

  it "should not warn of AR finder methods" do
    run_file_parse_and_check_for_no_info(@runner, "app/views/foo.html.erb", view_content)
  end
  
  def view_content(add_ar_finder = false, ar_finder_method = "find")
    <<-EOF
    This is a view file
    #{"<% objects = Olaf."+ar_finder_method+" %>" if add_ar_finder}
    EOF
  end
  
end
