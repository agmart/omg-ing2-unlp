class Tag < ActiveRecord::Base
  # Clase Categoría.
  has_and_belongs_to_many :books

  validates :nombre, length: { minimum: 2, maximum: 50 }, uniqueness: true
end
