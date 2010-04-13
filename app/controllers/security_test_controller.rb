class SecurityTestController < ApplicationController
  
  def index
    @rbp_run_hash = RbpCommons.run
  end

end
