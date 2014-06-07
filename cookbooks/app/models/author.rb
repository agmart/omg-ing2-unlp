# encoding: utf-8
class Author < ActiveRecord::Base
  # Asociaciones
  #has_one :book
  before_validation :strip_nombre, :only => [:nombre, :dni]

  validates :nombre,
    presence: true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ ]+\z/, message: "sólo permite letras" }

  validates :dni, :numericality => { :greater_than => 0, :less_than_or_equal_to => 99999999 }
  validates_uniqueness_of :dni, scope: [:dni, :nombre]

  def strip_nombre
    self.nombre = self.nombre.squish
    self.dni = self.dni.to_s.squish
  end
end
