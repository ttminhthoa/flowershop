class CategoriesProduct< ActiveRecord::Base
  def self.addcategory(idcategory)
    li=self.new
    li.category_id=idcategory
    li
  end
end