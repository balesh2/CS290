module MakeSearchable
  extend ActiveSupport:Concern

  included do
    searchable :auto_index => true, :include => [:users, :posts]

    #Text
    text "title"
    text "description"
    text :users do
      users.map(&:username)
    end

    #Facets
    string :coords, :stored => true, :multiple => false do
      coords
    end
    string :creator, :stored => true, :multiple => false do
      users.map(&:username)
    end

    #Displayed Texts
    Posts.displayes_texts.each do |text|
      string text, :stored => true
    end
  end

  module ClassMethods
    def displayed_texts
      [:title, :description, :user_id]
    end
  end
end
