class Author < ApplicationRecord
  has_many :books
  # t.string :name
  # t.integer :year_born
  # t.integer :year_of_death
end
