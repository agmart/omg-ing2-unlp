class Author < ActiveRecord::Base
  # Asociaciones
  has_one :book

  # Validaciones
  validates :book, presence: true

end
