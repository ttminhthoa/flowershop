class OrderDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  def self.from_cart_item(cart_item)
    li=self.new
    li.product = cart_item.product
    li.final_quantity = cart_item.quantity
    li.final_price = cart_item.price
    li
  end
end