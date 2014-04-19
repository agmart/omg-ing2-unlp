class Tag < ActiveRecord::Base
  # Clase Categoría.
  has_and_belongs_to_many :books
end
