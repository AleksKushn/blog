class Post < ApplicationRecord
  include PgSearch

  has_many :comments, :foreign_key => 'post_id'
  has_many :tags, :foreign_key => 'post_id'
  belongs_to :author, class_name: User

  validates :author, presence: true
  validates :date, presence: true
  validates :title, presence: true
  validates :content, presence: true

  scope :find_by_field_substring, ->(query) do
         order(id: :asc)
        .joins('LEFT OUTER JOIN comments ON comments.post_id = posts.id' )
        .joins('LEFT OUTER JOIN tags ON tags.post_id = posts.id')
        .where 'CONCAT(posts.title,posts.content,comments.content,tags.name) LIKE ?', "%#{sanitize_sql_like(query)}%"

  end


  multisearchable against: [:title, :content]

  after_save :reindex


  def as_json(options = {})
    {
        :id            => id,
        :author_id     => author_id,
        :date          => date,
        :title         => title,
        :content       => content,
        :comments      => comments.sort { |a, b| a.id <=> b.id }.as_json(options),
        :tags          => tags.sort { |a, b| a.id <=> b.id }.as_json(options),
        :created_at    => created_at,
        :updated_at    => updated_at
    }
  end
  private

  def reindex
    PgSearch::Multisearch.rebuild(Post)
  end
end
