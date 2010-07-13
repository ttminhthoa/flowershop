class FlowerController < ApplicationController
  
  layout "flower"
  before_filter :login_required, :only =>[:checkout,:myaccount,:change_password]

  def change_password_update
    if Customer.authenticate(current_customer.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_customer.password_confirmation = params[:password_confirmation]
        current_customer.password = params[:password]
                
        if current_customer.save!
          flash[:notice] = "Password successfully updated"
          redirect_to login_path
        else
          flash[:alert] = "Password not changed"
          render :action => 'change_password'
        end
                 
      else
        flash[:alert] = "New Password mismatch"
        render :action => 'change_password'
      end
    else
      flash[:alert] = "Old password incorrect"
      render :action => 'change_password'
    end
  end
  def change_password
     @sort45 = @language.constant_menus.find_by_sort(45).menu_name
     @sort48 = @language.constant_menus.find_by_sort(48).menu_name
     @sort49 = @language.constant_menus.find_by_sort(49).menu_name
     @sort50 = @language.constant_menus.find_by_sort(50).menu_name
  end
  def myaccount
    @sort19 = @language.constant_menus.find_by_sort(19).menu_name
    @sort21 = @language.constant_menus.find_by_sort(21).menu_name
    @sort24 = @language.constant_menus.find_by_sort(24).menu_name
    @sort22 = @language.constant_menus.find_by_sort(22).menu_name
    @sort44 = @language.constant_menus.find_by_sort(44).menu_name
    @sort45 = @language.constant_menus.find_by_sort(45).menu_name
    @customer = current_customer
  end
  def search
    unless params[:search].blank?
      @search = params[:search]
      #@products = ProductDescription.paginate :page => params[:page], :per_page => 9, :order => 'id DESC',:conditions=>[" product_description like? and language_id=?","%#{@search}%",@language]
      @products =   ProductDescription.find_by_language_id(@language)
    else
      #@products =ProductDescription.paginate :page=>params[:page],:per_page=>9,:order =>'id DESC'
      @products = ProductDescription.find_by_language_id(@language)
    end
    render :partial=>'search', :layout=>false
  end
  def searchproduct
    @products = ProductDescription.find_by_language_id(@language)
    #@products = ProductDescription.paginate :page => params[:page], :per_page => 9, :order => 'id DESC',:conditions=>[" product_description like? and language_id=?","%#{@search}%",@language]
  end
  def index
    @sort16 = @language.constant_menus.find_by_sort(16).menu_name
    @sort17 = @language.constant_menus.find_by_sort(17).menu_name
    @newproducts = Product.find(:all,:limit=>6,:order=>"rand()",:conditions=>["isnew=? and status=?",1,1])
    @featured_products = Product.find(:all,:limit=>3,:order=>"rand()")
  end
  def aboutus
  end
  def changelanguage
    session[:idlanguage]= params[:id]
    redirect_to :back
  end
  def contact
    @sort21 = @language.constant_menus.find_by_sort(21).menu_name
    @sort22 = @language.constant_menus.find_by_sort(22).menu_name
    @sort23 = @language.constant_menus.find_by_sort(23).menu_name
    @sort28 = @language.constant_menus.find_by_sort(28).menu_name
    @sort29 = @language.constant_menus.find_by_sort(29).menu_name
    @sort30 = @language.constant_menus.find_by_sort(30).menu_name
    @sort31 = @language.constant_menus.find_by_sort(31).menu_name
  end
  def createcontact
    @contact=ContactUs.new(params[:contactus])
    if @contact.save
      flash[:thanks]="Cám ơn bạn đã liên hệ với <i>FLOWERSHOP</i><br/>Thông tin của bạn đã được gửi.<br/> Chúng tôi sẽ xử lý thông tin một cách nhanh nhất.<br/>Chúc bạn một ngày vui vẻ"
      redirect_to :action=>:contact,:controller=>:flower
    end
  end
  def details
    @sort17 = @language.constant_menus.find_by_sort(17).menu_name
    @sort32 = @language.constant_menus.find_by_sort(32).menu_name
    @idproduct=params[:id]
    @p=Product.find(@idproduct)
    @product=@p.product_descriptions.find(:first,:conditions=>["language_id=?",@language])
  end
  def category
    @idcategory=params[:id]
    @category=Category.find(@idcategory)
    @categoryname = @category.category_names.find(:all,:conditions=>["language_id=?",@language])
    @products = @category.products.paginate :page => params[:page], :per_page => 6
  end
  def add_to_cart
    #
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}" )
      flash[:notice] = "Invalid product"
      redirect_to :action => :index
    else
      @cart = find_cart
      @current_item = @cart.add_product(product)
      if request.xhr?
        respond_to { |format| format.js }
      else
        redirect_to :action =>:index,:controller=>:store
      end
    end
  end
  def newproduct
    @productnew = Product.paginate :page => params[:page], :per_page => 9, :order => 'id DESC',:conditions=>[" isnew=? and status=?",1,1]
  end
  def cart
    @sort35 = @language.constant_menus.find_by_sort(35).menu_name
    @sort36 = @language.constant_menus.find_by_sort(36).menu_name
    @sort37 = @language.constant_menus.find_by_sort(37).menu_name
   
    @sort39 = @language.constant_menus.find_by_sort(39).menu_name
    @sort40 = @language.constant_menus.find_by_sort(40).menu_name
    @sort41 = @language.constant_menus.find_by_sort(41).menu_name
  end
  def updatenum
    if params[:quantity]
      product = Product.find(params[:id])
      @cart = find_cart
      @cart.update(product,Integer(params[:quantity]))
      redirect_to :action => :cart
    end
  end
  def emptycart
    session[:cart]=nil
    redirect_to :action=>:index,:controller=>:flower
  end
  def checkout
    unless logged_in?
      store_location
    end
    @sort29 = @language.constant_menus.find_by_sort(29).menu_name
    @sort22 = @language.constant_menus.find_by_sort(22).menu_name
    @sort24 = @language.constant_menus.find_by_sort(24).menu_name
    @sort43 = @language.constant_menus.find_by_sort(43).menu_name
    unless flash[:saveorder]
      if @cart.items.empty?
        flash[:empty]="Your cart is empty!"
        redirect_to :action => :cart,:controller => :flower
      else
        @order =Order.new
      end
    end
    
  end
 
  def save_order
    @sort29 = @language.constant_menus.find_by_sort(29).menu_name
    @sort22 = @language.constant_menus.find_by_sort(22).menu_name
    @sort24 = @language.constant_menus.find_by_sort(24).menu_name
    @sort43 = @language.constant_menus.find_by_sort(43).menu_name
    
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      flash[:saveorder]=("Thank you for your order" )
      redirect_to :action => :checkout,:controller =>:flower
    else
      render :action => :checkout
    end
  end

end
