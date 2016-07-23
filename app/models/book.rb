class Book < ApplicationRecord
  establish_connection Rails.configuration.database_configuration['calibre']

  has_and_belongs_to_many :authors,
      join_table: 'books_authors_link',
      foreign_key: 'book',
      association_foreign_key: 'author'

  has_many :data, class_name: 'BookFile', foreign_key: 'book'

  def author
    unless self.authors.empty?
      self.authors[0]
    end
  end

  def date_published
    self.pubdate.strftime("%B %d, %Y")
  end
end
