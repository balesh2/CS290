module MakeSearchable
  extend ActiveSupport:Concern

  included do
    searchable :auto_index => true, :include => [:users, :posts]

    #Text
    text :posts do
      posts.map(&:title)
      posts.map(&:description)
      posts.map(&:photo)
    end
    text :users do
      users.map(&:username)
    end

    #Facets
    string :title, :stored => true, :multiple => false do
      posts.map(&:title)
    end
    string :coords, :stored => true, :multiple => false do
      posts.map(&:coords)
    end
    string :username, :stored => true, :multiple => false do
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
