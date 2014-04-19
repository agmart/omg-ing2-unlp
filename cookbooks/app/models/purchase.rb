class Purchase < ActiveRecord::Base
  # Clase +compra+. Representa una compra ya efectuada
  # luego de que se armó el carro y se pagó.
  # Posee un +estado+

  has_and_belongs_to_many :books
end
