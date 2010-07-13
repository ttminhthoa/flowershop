class Order < ActiveRecord::Base
  has_many :order_details
  belongs_to :customer
 
  validates_presence_of :recipient, :address, :phone

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = OrderDetail.from_cart_item(item)
      order_details << li
    end
  end
  
end