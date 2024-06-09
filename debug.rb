require_relative 'Author'
require_relative 'Article'
# require 'date'
# published_at = DateTime.now
# puts "Title: #{published_at}"

# Define Romain as an Author
author = Author.new("Romain", "charretteur.r@gmail.com")
# Create first article without publish date
article = Article.new("My book", "Hello world.", author)
# Print the book
puts article
# Publish article
article.publish
# Print published article
puts article
