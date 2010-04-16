class User < ActiveRecord::Base
  attr_accessor :new_password
  attr_accessor :terms_of_service
  #attr_accessible :name

  has_many :posts
end
