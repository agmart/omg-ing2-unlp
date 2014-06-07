# encoding: utf-8
class Author < ActiveRecord::Base
  # Asociaciones
  has_one :book

  validates :nombre,
    presence: true,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ ]+\z/, message: "sólo permite letras" }

  validates :dni, :numericality => { :greater_than => 0, :less_than_or_equal_to => 99999999 }
  validates_uniqueness_of :dni, scope: [:dni, :nombre]


end
