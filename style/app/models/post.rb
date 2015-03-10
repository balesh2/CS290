class Post < ActiveRecord::Base
  include SunspotModel
  include MakeSearchable

  validates :title, :presence => true
end
