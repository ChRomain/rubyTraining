namespace :import do
  desc "Import data present in csv to sql db"

  task :articles => :environment do
    puts "Start imported articles"
    require 'csv'

    articles_csv_file = Rails.root.join('lib', 'assets', 'articles.csv')
    columns = [:title, :body, :author_id, :published_at]
    total_articles = 0
    total_errors = 0

    CSV.foreach(articles_csv_file, headers: true) do |row|
      data = row.to_hash
      article_data = {}
      columns.each do |column|
        article_data[column] = data[column.to_s]
      end
      begin
        Article.create!(article_data)
        total_articles += 1
        puts "Importing article ##{total_articles}"
      rescue => e
        total_errors += 1
        puts "Error importing article: #{e.message}"
      end
    end

    puts "Articles imported with #{total_errors} errors!"
  end

  task :authors => :environment do
    puts "Start imported authors"
    require 'csv'

    authors_csv_file = Rails.root.join('lib', 'assets', 'authors.csv')
    columns = [:name, :email]
    total_authors = 0
    total_errors = 0

    CSV.foreach(authors_csv_file, headers: true) do |row|
      data = row.to_hash
      author_data = {}

      columns.each do |column|
        author_data[column] = data[column.to_s]
      end
      begin
        Author.create!(author_data)
        total_authors += 1
        puts "Importing author ##{total_authors}"
      rescue => e
        total_errors += 1
        puts "Error importing author: #{e.message}"
      end
    end

    puts "Authors imported with #{total_errors} errors!"
  end

  task :all => [:authors, :articles]
end
