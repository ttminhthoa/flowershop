class OrderController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
 def listorders
    @ordernews = Order.find(:all,:conditions=>["status=?",0])
    @count =0 
    for @c in @ordernews
      @count = @count +1
    end
    @orders = Order.find(:all).paginate :page => params[:page], :per_page => 10, :order => 'id DESC'
  end
  def show
    @order=Order.find(params[:id])
    @orderdetails = OrderDetail.find(:all,:conditions=>["order_id=?",params[:id]])
  end
  def edit
    @order=Order.find(params[:id])
  end
  def update
    @order=Order.find(params[:id])
    @order.update_attributes(params[:order])
    redirect_to :action =>:listorders,:controller=>:order
  end
end
