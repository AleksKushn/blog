class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: User


  validates :post, presence: true
  validates :date, presence: true
  validates :author, presence: true
  validates :content, presence: true
end
