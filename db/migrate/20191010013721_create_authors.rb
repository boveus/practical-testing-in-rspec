class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :year_born
      t.integer :year_of_death

      t.timestamps
    end
  end
end
