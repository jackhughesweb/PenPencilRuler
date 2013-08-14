class Subject < ActiveRecord::Base
  attr_accessible :color, :examboard, :name
  has_many :topics, dependent: :delete_all
end
