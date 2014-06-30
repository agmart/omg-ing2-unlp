# encoding: utf-8
class Book < ActiveRecord::Base
  before_validation :strip_titulo, :only => [:titulo]
  
  # Asociaciones
  belongs_to :author
  belongs_to :editorial
  has_and_belongs_to_many :purchases, join_table: 'purchase_book'
  has_and_belongs_to_many :tags, join_table: 'tag_book'
  has_many :cart_book
  
  # Validaciones
  validates :author, :isbn, :editorial, :titulo, :paginas, :precio, :ano_publicacion, presence: true
  validates :isbn, uniqueness: true
   
  validates :titulo,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }

  validates :isbn, :paginas, numericality: { only_integer: true, :greater_than => 0, message: "debe ser un número entero" }
  validates :paginas, numericality: { :less_than => 10000, message: "debe ser menor que 10.000" }
  validates :precio, numericality: { only_integer: true, :greater_than => 0, message: "debe ser un número entero mayor a $0" }
  validates :precio, numericality: { :less_than => 100000, message: "debe ser menor que $100.000" }
  
  validates :ano_publicacion, 
    numericality: { greater_than: 0, message: "debe ser mayor a 0" }
  validates :ano_publicacion, 
    numericality: { only_integer: true, message: "debe ser un número entero" }
  validates :ano_publicacion, 
    numericality: { less_than: 2015, message: "debe ser menor que 2014"}
  
  
  
  def strip_titulo
    self.titulo = self.titulo.squish
  end
  
  def try_tags
    if tags.any?
      tags2 = []
      tags.each do |t|
        tags2 << t.nombre
      end
      tags2.join ' '
    else
      ""
    end
  end
end