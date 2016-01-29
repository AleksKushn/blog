class Tag < ApplicationRecord
  include PgSearch

  belongs_to :post
  validates :name, presence: true

  multisearchable against: :name

  after_save :reindex

  def as_json(options = {})
    {
        :id          => id,
        :post_id     => post_id,
        :name        => name,
        :created_at  => created_at,
        :updated_at  => updated_at
    }
  end
  private

  def reindex
    PgSearch::Multisearch.rebuild(Tag)
  end
end
