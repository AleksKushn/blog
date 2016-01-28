class Comment < ApplicationRecord
  include PgSearch

  belongs_to :post
  belongs_to :author, class_name: User


  validates :post, presence: true
  validates :date, presence: true
  validates :author, presence: true
  validates :content, presence: true

  multisearchable against: :content

  after_save :reindex

  private

  def reindex
    PgSearch::Multisearch.rebuild(Comment)
  end
end
