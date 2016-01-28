class User < ApplicationRecord
  has_many :posts, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id

  has_secure_password
  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,  length: { minimum: 6 }
end
