class Category < ActiveRecord::Base
  has_many :category_names
  has_and_belongs_to_many :products
end
