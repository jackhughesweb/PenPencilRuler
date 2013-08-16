class Subject < ActiveRecord::Base
  attr_accessible :color, :examboard, :name
  belongs_to :user
  has_many :topics, dependent: :delete_all
  validates :name, presence: true
end
