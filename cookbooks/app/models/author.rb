class Author < ActiveRecord::Base
  # Asociaciones
  has_one :book
end
