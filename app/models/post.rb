class Post < ApplicationRecord
  has_many :comments, :foreign_key => 'post_id'
  has_many :tags, :foreign_key => 'post_id'
  belongs_to :author, class_name: User

  validates :author, presence: true
  validates :date, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
