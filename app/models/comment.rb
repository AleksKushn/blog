class Comment < ApplicationRecord
  include PgSearch

  belongs_to :post
  belongs_to :author, class_name: User


  validates :post, presence: true
  validates :date, presence: true
  validates :author, presence: true
  validates :content, presence: true

  multisearchable against: :content

  #after_save :reindex

  def as_json(options = {})
    {
        :id            => id,
        :post_id       => post_id,
        :author_id     => author_id,
        :date          => date,
        :content       => content,
        :created_at    => created_at,
        :updated_at    => updated_at
    }
  end

  private

  def reindex
    PgSearch::Multisearch.rebuild(Comment)
  end
end
