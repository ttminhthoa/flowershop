class ProductDescription < ActiveRecord::Base
  belongs_to :product
  belongs_to :language
  
end