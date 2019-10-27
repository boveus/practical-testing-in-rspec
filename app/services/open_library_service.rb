module OpenLibraryService
  extend self

  # TODO: The API returns the number of results found, we can do multiple queries to retrieve the next 100 results
  # by appending &page=<number> to subsequent API requests
  # the last page should be == to pages_to_request = (book_json["num_found"] / 100) + 1
  # It currently only returns the first 100 results
  def create_books_by_author(author_name)
    author_id = Author.find_or_create_by(name: author_name).id
    book_json = Faraday.get("http://openlibrary.org/search.json?author=#{author_name}").body
    add_books_to_db(book_json, author_id)
  end

  def add_books_to_db(book_json, author_id)
    values = JSON.parse(book_json)['docs'].map do |result|
      title = result["title_suggest"].tr("'", "\\\\'")
      "('#{title}',#{author.id},'#{Time.now}','#{Time.now}')"
    end
    ActiveRecord::Base.connection.execute("INSERT OR IGNORE INTO books (title, author_id, created_at, updated_at) VALUES #{values.join(',')}")
  end

  #TODO This currently retrieves the first search result's isbn, we may need to add logic to find the most relevent result
  def find_isbn_for_book(book)
    isbns_json = Faraday.get("http://openlibrary.org/search.json?title=#{book.title}").body
    JSON.parse(isbns_json)["docs"].first["isbn"]
  end

  def update_book_data_from_api(book)
    return if book.url
    isbns = find_isbn_for_book(book)
    isbn = "ISBN:#{isbns.first}"
    book_json = Faraday.get("http://openlibrary.org/api/books?bibkeys=#{isbn}&jscmd=data&format=json").body
    result = JSON.parse(book_json)[isbn]
    return unless result
    book.update(
      subtitle: result.dig('subtitle'),
      page_count: result.dig('number_of_pages'),
      url: result.dig('url'),
      cover_url: result.dig('cover', 'large') || result.dig('cover', 'small'),
      isbn: isbns.join(';')
    )
  end
end
