class Editorial < ActiveRecord::Base
  has_one :book

  validates :nombre, length: { minimum: 2, maximum: 50 }, uniqueness: true
end
