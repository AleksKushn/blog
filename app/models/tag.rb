class Tag < ApplicationRecord
  include PgSearch

  belongs_to :post
  validates :name, presence: true

  multisearchable against: :name

  after_save :reindex

  private

  def reindex
    PgSearch::Multisearch.rebuild(Tag)
  end
end
