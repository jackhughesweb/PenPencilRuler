class Note < ActiveRecord::Base
  attr_accessible :text, :topic_id, :title
  belongs_to :topic
  validates :text, presence: true
end
