class Language < ActiveRecord::Base
  has_many :product_descriptions
  has_many :category_names
  has_many :constant_menus
  has_many :products, :through => :product_descriptions , :uniq => true
end
