class Purchase < ActiveRecord::Base
  # Clase +compra+. Representa una compra ya efectuada
  # luego de que se armó el carro y se pagó.
  # Posee un +estado+
  scope :fecha_min,  -> (min_fecha) { where("created_at >= ?", min_fecha) }
  scope :fecha_max,  -> (max_fecha) { where("created_at <= ?",  max_fecha) }
  
  belongs_to :user
  has_many :purchase_books, dependent: :destroy
end
