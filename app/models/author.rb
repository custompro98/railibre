class Author < ApplicationRecord
  establish_connection Rails.configuration.database_configuration['calibre']

  has_and_belongs_to_many :books,
    join_table: 'books_authors_link',
    foreign_key: 'author',
    association_foreign_key: 'book'
end
