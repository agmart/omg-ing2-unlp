class Book < ActiveRecord::Base
  # Asociaciones
  belongs_to :author
  belongs_to :editorial
  has_and_belongs_to_many :carts
  has_and_belongs_to_many :purchases
  has_and_belongs_to_many :tags

  # Validaciones
  # se va hasta que este hecho el alta de author
  #validates :author, presence: true

  def index
  end
end
