# 500.times do
#   book = Faker::Book
#   author = Author.find_or_create_by(name: book.author)
#   new_book = Book.find_or_create_by(title: book.title,
#                                     author: author,
#                                     genre: genre
#                                     )
# end