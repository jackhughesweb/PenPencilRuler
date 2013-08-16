class Note < ActiveRecord::Base
  attr_accessible :text, :topic_id
  belongs_to :topic
  validates :text, presence: true
end
