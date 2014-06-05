class Book < ActiveRecord::Base
  # Asociaciones
  belongs_to :author
  belongs_to :editorial
  has_and_belongs_to_many :carts, join_table: 'cart_book'
  has_and_belongs_to_many :purchases, join_table: 'purchase_book'
  has_and_belongs_to_many :tags, join_table: 'tag_book'

  # Validaciones
  # se va hasta que este hecho el alta de author
  #validates :author, presence: true

  def index
  end
end
