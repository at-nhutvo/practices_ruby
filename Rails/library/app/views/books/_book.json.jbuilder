json.extract! book, :id, :category, :title, :description, :image, :price, :status, :created_at, :updated_at
json.url book_url(book, format: :json)
