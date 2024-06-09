class Author < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def to_s
    "Author: #{name} (#{email})"
  end
end
