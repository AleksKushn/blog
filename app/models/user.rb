class User < ApplicationRecord
  has_many :posts, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id

  has_secure_password
  before_create :set_initial_api_key
  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :api_key, uniqueness: true


  def as_json(options = {})
    {
        :id            => id,
        :name          => name,
        :email         => email,
        :created_at    => created_at,
        :updated_at    => updated_at
    }
  end

  private

  def set_initial_api_key
    self.api_key ||= generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

end
