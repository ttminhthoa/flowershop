class Product < ActiveRecord::Base
  has_many :product_descriptions
  has_many :languages , :through => :product_descriptions, :uniq => true
  has_and_belongs_to_many :categories
  has_many :order_details
  belongs_to :picture
  has_many :categories_products
  def addproductcategory(idcategory)
    li =  CategoriesProduct.addcategory(idcategory)
    categories_products << li
  end
end