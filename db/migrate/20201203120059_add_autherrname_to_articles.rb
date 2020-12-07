class AddAutherrnameToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :authername, :string
    add_index :articles, :authername, unique: false
  end
end
