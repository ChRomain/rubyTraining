require 'date'
require_relative 'Author'

class Article
  # Getter generator
  attr_reader :title, :body, :author, :published_at

  def initialize(title, body, author, published_at = nil)
    @title = title
    @body = body
    @author = author
    @published_at = published_at
  end

  # Initialize publish to current date
  # DateTime.now format is YYYY-MM-DDTHH:mm:ss+TZ
  def publish
    @published_at = DateTime.now
  end

  def to_s
    articleStr = "Title: #{@title}\nBody: #{@body}\nAuthor name: #{author.name} - Author email: #{author.email}"
    articleStr += "\nPublished At: #{@published_at}" if @published_at
    articleStr
  end
end
