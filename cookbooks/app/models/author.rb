class Author < ActiveRecord::Base
  # Asociaciones
  has_one :book

  validates :nombre, presence: true
end
