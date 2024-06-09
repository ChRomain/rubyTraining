class Article < ApplicationRecord
  belongs_to :author

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true

  def publish
    self.published_at = DateTime.now
  end

  def to_s
    article_str = "Title: #{title}\nBody: #{body}\nAuthor: #{author.name} (#{author.email})"
    article_str += "\nPublished At: #{published_at}" if published_at
    article_str
  end
end
