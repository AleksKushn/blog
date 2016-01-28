class Post < ApplicationRecord
  include PgSearch

  has_many :comments, :foreign_key => 'post_id'
  has_many :tags, :foreign_key => 'post_id'
  belongs_to :author, class_name: User

  validates :author, presence: true
  validates :date, presence: true
  validates :title, presence: true
  validates :content, presence: true

  multisearchable against: [:title, :content]

  after_save :reindex

  private

  def reindex
    PgSearch::Multisearch.rebuild(Post)
  end
end
