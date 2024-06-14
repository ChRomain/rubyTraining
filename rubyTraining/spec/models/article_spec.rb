require 'rails_helper'

# Note: Here we just answers to question 4th of first exercise.
# We just check that getter are ok.
# Corner, validation, robustness, disaster (db down), authorization case etc are missing

RSpec.describe Article, type: :model do
  let(:author) { Author.create(name: "J.K. Rowling", email: "mail@gmail.com") }
  let(:published_at) { Time.now }
  let(:article) { Article.new(title: "Harry Potter", body: "Le prisonnier d'Azkaban.", author: author, published_at: published_at) }

  describe '#title' do
    it 'returns article title' do
      expect(article.title).to eq("Harry Potter")
    end
  end

  describe '#body' do
    it 'returns article body' do
      expect(article.body).to eq("Le prisonnier d'Azkaban.")
    end
  end

  describe '#author' do
    it 'returns the author of the article' do
      expect(article.author).to eq(author)
    end
  end

  describe '#published_at' do
    it 'returns the published_at of the article' do
      # Due to time limitation - Here we only compare date of published and we omit hours, min, secs
      # TODO: Compare whole string with an offset
      expect(article.published_at.to_date).to eq(published_at.to_date)
    end
  end
end
