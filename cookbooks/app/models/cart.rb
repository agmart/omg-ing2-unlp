class Cart < ActiveRecord::Base
  #Asociaciones
  belongs_to :user
  has_many :cart_book

end
