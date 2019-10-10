json.extract! author, :id, :name, :year_born, :year_of_death, :created_at, :updated_at
json.url author_url(author, format: :json)
