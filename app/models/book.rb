class Book < ApplicationRecord
  establish_connection Rails.configuration.database_configuration['calibre']

  has_and_belongs_to_many :authors,
      join_table: 'books_authors_link',
      foreign_key: 'book',
      association_foreign_key: 'author'

  has_one :data, class_name: 'BookFile', foreign_key: 'book'

  def author
    unless self.authors.empty?
      self.authors[0]
    end
  end

  def cover_path
    "/calibre-library/#{self.path}/cover.jpg"
  end

  def date_published
    self.pubdate.strftime("%B %d, %Y")
  end

  def has_cover?
    has_cover == 1
  end
end
