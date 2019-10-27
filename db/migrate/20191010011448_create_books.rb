class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :page_count
      t.references :author, null: false, foreign_key: true

      t.index :title, unique: true
      t.timestamps
    end
  end
end
