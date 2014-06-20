class Book < ActiveRecord::Base
  before_validation :strip_titulo, :only => [:titulo]
  
  # Asociaciones
  belongs_to :author
  belongs_to :editorial
  has_and_belongs_to_many :carts, join_table: 'cart_book'
  has_and_belongs_to_many :purchases, join_table: 'purchase_book'
  has_and_belongs_to_many :tags, join_table: 'tag_book'

  # Validaciones
  # se va hasta que este hecho el alta de author
  validates :author, :isbn, :editorial, :titulo, :paginas, :precio, :ano_publicacion, presence: true
 
   
  validates :titulo,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }

  validates :isbn, :paginas, numericality: { only_integer: true, message: "debe ser un número entero" }
  validates :precio, numericality: true
  validates :ano_publicacion, 
    numericality: { only_integer: true, message: "debe ser un número entero" },
    numericality: { greater_than: 0, message: "debe ser mayor a 0" },
    numericality: { less_than: 2050, message: "debe ser menor que 2050"}

  def strip_titulo
    self.titulo = self.titulo.squish
  end
end
