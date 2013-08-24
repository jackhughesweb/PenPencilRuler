class Topic < ActiveRecord::Base
  attr_accessible :name, :subject_id
  has_many :notes, dependent: :delete_all
  belongs_to :subject
  belongs_to :user
  validates :name, presence: true
end
