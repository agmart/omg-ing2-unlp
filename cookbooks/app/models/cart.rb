class Cart < ActiveRecord::Base
  #Asociaciones
  belongs_to :user
  has_and_belongs_to_many :books

  #Validaciones
  validates :user, presence: true
end
