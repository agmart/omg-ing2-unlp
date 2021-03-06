# encoding: utf-8
class Book < ActiveRecord::Base
  before_validation :strip_titulo, :only => [:titulo]
  
  # Asociaciones
  belongs_to :author
  belongs_to :editorial
  has_and_belongs_to_many :tags, join_table: 'tag_book'
  has_many :cart_book
  has_many :purchase_books

  # Validaciones
  validates :author, :isbn, :editorial, :titulo, :paginas, :precio, :ano_publicacion, presence: true
  validates :isbn, uniqueness: true
  validates :isbn, numericality: { less_than: 9999999999999, message: "no puede tener más de 13 dígitos" }
   
  validates :titulo,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }

  validates :isbn, :paginas, numericality: { only_integer: true, :greater_than => 0, message: "debe ser un número entero" }
  validates :paginas, numericality: { :less_than => 10000, message: "debe ser menor que 10.000" }
  validates :precio, numericality: { greater_than: 0, less_than: 100000, message: "debe estar entre $0 y $100.000" }
  
  validates :ano_publicacion, 
    numericality: { greater_than: 1900, message: "debe ser mayor a 1900" }
  validates :ano_publicacion, 
    numericality: { only_integer: true, message: "debe ser un número entero" }
  validates :ano_publicacion, 
    numericality: { less_than: 2015, message: "debe ser menor que 2014"}
 
  scope :isbn, -> (isbn) { where isbn: isbn }
  scope :paginas_min, -> (min_pags) { where("paginas >= ?", min_pags) }
  scope :paginas_max, -> (max_pags) { where("paginas <= ?", max_pags) }
  scope :precio_min,  -> (min_precio) { where("precio >= ?", min_precio) }
  scope :precio_max,  -> (max_precio) { where("precio <= ?",  max_precio) }
  scope :author_id,       -> (autor_id) { where author_id: autor_id }
  scope :titulo,      -> (titulo)   { where("titulo like ?", "%#{titulo}%") }
  scope :ano_pub_min, -> (min_ano_pub) { where("ano_publicacion >= ?", min_ano_pub) }
  scope :ano_pub_max, -> (max_ano_pub) { where("ano_publicacion <= ?", max_ano_pub) }
  
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
