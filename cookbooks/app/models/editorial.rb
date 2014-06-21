# encoding: utf-8
class Editorial < ActiveRecord::Base
  #has_one :book
  before_validation :strip_nombre, :only => [:nombre, :direccion]

  validates :nombre,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }

  validates :direccion,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }
 
  validates_uniqueness_of :direccion, scope: [:nombre, :direccion]

  def strip_nombre
    self.nombre = self.nombre.squish
    self.direccion = self.direccion.squish
  end

  def to_s
    nombre
  end
end
