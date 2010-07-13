class CartItem
    attr_reader :product,:quantity
  def initialize(product)
    @product = product
    @quantity = 1
  end
  def increment_quantity
    @quantity += 1
  end
  def update_quantity(num)
    @quantity = num
  end
  def title
    @product.title
  end
  def unitprice
    #@product.price
    if @product.ispromotion == 1
      (@product.price - (@product.price * 0.1))
    else
      @product.price
    end
  end
  def price
    if @product.ispromotion == 1
      (@product.price - (@product.price * 0.1))*@quantity
    else
      @product.price * @quantity  
    end
  end
  def image
    @product.picture.public_filename()
  end
  def productds(language)
    ProductDescription.find(:first,:conditions=>["language_id=? and product_id=?",language,@product])
  end
end