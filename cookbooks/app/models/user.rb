class User < ActiveRecord::Base
  # Clase Usuario. Puede ser administrador o usuario normal.

  has_one :cart
  has_many :purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def new
  end

  def create
    cart = Cart.new
  end

end
