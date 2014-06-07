# encoding: utf-8
class Tag < ActiveRecord::Base
  # Clase Categoría.
  #has_and_belongs_to_many :books

  validates :nombre,
    presence:true,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    uniqueness: true,
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }
end
