class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation if Rails::VERSION::MAJOR < 4

  include Blacklight::User

  devise :database_authentication, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
