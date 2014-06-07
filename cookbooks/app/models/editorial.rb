# encoding: utf-8
class Editorial < ActiveRecord::Base
  has_one :book

  validates :nombre,
    presence:true,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }
end
