module OpenLibraryService
  extend self

  def find_books_by_author(author_name)
    book_json = Faraday.get("http://openlibrary.org/search.json?author=#{author_name}").body
    results = JSON.parse(book_json)["docs"]
    results.map! do |result|
      { isbns: result["isbn"], title: result["title"] }
    end
    results
  end

  def find_book_by_isbn(isbn)
    isbn = "ISBN:#{isbn}"
    book_json = Faraday.get("https://openlibrary.org/api/books?bibkeys=#{isbn}&format=json&jscmd=data").body
    results = JSON.parse(book_json).dig(isbn)
    {
     title: results["title"],
     subtitle: results["subtitle"],
     pages: results["number_of_pages"],
     url: results["url"],
     cover: results.dig("cover", "large") || results.dig("cover", "small")
    }
  end
end