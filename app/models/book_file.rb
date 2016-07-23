class BookFile < ApplicationRecord
  establish_connection Rails.configuration.database_configuration['calibre']

  self.table_name = 'data'

  belongs_to :book, foreign_key: 'book'
end
