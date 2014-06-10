# encoding: utf-8
class Tag < ActiveRecord::Base
  # Clase Categoría.
  #has_and_belongs_to_many :books
  before_validation :strip_nombre, :only => [:nombre]

  validates :nombre,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    uniqueness: true,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }

  def strip_nombre
	self.nombre = self.nombre.squish
  end
end
