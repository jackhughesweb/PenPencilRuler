class Note < ActiveRecord::Base
  attr_accessible :text, :topic_id, :title
  belongs_to :topic
  belongs_to :user
  validates :title, presence: true
  validates :text, presence: true
end
