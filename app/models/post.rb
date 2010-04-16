class Post < ActiveRecord::Base
  attr_accessor :new_password
  attr_accessor :terms_of_service

  attr_protected :post_data
end
