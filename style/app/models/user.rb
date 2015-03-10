class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation if Rails::VERSION::MAJOR < 4

  include Blacklight::User

end
