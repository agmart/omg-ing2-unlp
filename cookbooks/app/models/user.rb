# encoding: utf-8
class User < ActiveRecord::Base
  # Clase Usuario. Puede ser administrador o usuario normal.

  has_one :cart
  has_many :purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nombre,
    presence: true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ ]+\z/, message: "sólo permite letras" }

  validates :dni,
    presence: true, 
    numericality: { only_integer: true, message: "debe ser un número entero" },
    numericality: { greater_than: 0, message: "debe ser mayor a 0" },
    numericality: { less_than: 99999999, message: "debe ser menor que 99.999.999"} 

  validates :direccion,
    presence:true,
    case_sensitive: false,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚ0-9 ]+\z/, message: "sólo permite letras y números" }
  
  validates :tel,
    presence:true,
    allow_blank: false,
    length: { minimum: 2, maximum: 50 },
    format: { with: /\A[\-0-9 ]+\z/, message: "sólo permite números y '-'" }

  before_create :crear_carro


  def new
  end

  def create
  end

  private
    def crear_carro
      build_cart
      true
    end

end
