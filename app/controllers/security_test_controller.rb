class SecurityTestController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  filter_parameter_logging :password
  
  def index
    @rbp_run_hash = RbpCommons.run
  end

end
