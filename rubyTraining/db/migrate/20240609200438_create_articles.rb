class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.references :author, null: false, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
