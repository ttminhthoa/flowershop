class CategoryName < ActiveRecord::Base
  belongs_to :category
  belongs_to :language
end