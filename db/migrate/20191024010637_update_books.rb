class UpdateBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :subtitle, :string
    add_column :books, :url, :string
    add_column :books, :cover_url, :string
    add_column :books, :isbn, :string
  end
end
