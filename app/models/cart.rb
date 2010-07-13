class Cart
  attr_reader :items
  def initialize
    @items=[]
  end
  def add_product(product)
    current_item = @items.find{|item| item.product == product}
    if current_item
      current_item.increment_quantity
    else
      current_item=CartItem.new(product)
      @items << current_item
    end
    current_item
  end
  def update(product, num)
    cur = @items.find {|i| i.product == product}
    if num == 0
        @items.delete(cur)
    else
        cur.update_quantity(num)
    end
 
  end
  def total_price
    @items.sum{|item| item.price}
  end
  def total_items
    @items.sum{|item| item.quantity}
  end
  def totalitems
    @count =0
    for item in @items
      @count = @count +1
    end
    @count
  end
end