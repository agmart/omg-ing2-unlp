class Purchase < ActiveRecord::Base
  # Clase +compra+. Representa una compra ya efectuada
  # luego de que se armó el carro y se pagó.
  # Posee un +estado+
  belongs_to :user
  has_many :purchase_books, dependent: :destroy
end
