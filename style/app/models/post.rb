class Post < ActiveRecord::Base
  include SunspotModel

  validates :title, :presence => true
end
