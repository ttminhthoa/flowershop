class ProductController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
  def listproduct
    @language = session[:idlanguage]||1
    @products =Product.find(:all,:conditions=>["status=?",1])
    @productdetails=[]
    for product in @products
      @productdetails << product.product_descriptions.find_by_language_id(@language) 
    end
    @listproduct=@productdetails.paginate :page => params[:page], :per_page => 6, :order => 'id DESC'
  end
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy && @product.product_descriptions.destroy
      redirect_to :action=>:listproduct,:controller=>:product
    end
  end
  def show
    @idproduct=params[:id]
   @idcategory = params[:idcategory]
    @product = Product.find(@idproduct)
    @products =@product.product_descriptions
  
  end
  def edit 
    @product = Product.find(params[:id])
    @product_description =@product.product_descriptions
    @picture = @product.picture
    @idcategory = params[:idcategory]
  end
  def update
    @product = Product.find(params[:idproduct])
    @picture=@product.picture
    @idcategory = params[:id]
    if @product.update_attributes(params[:product]) and @picture.update_attributes(params[:picture])
      ProductDescription.update(params[:product_description].keys,params[:product_description].values)
      redirect_to :action=>:show,:controller =>:category,:id => @idcategory
    end
  end
  def new
   @product_description=ProductDescription.new
   @idcategory = params[:id]
   @categories = CategoryName.find(:all, :order => "category_name",:conditions=>["language_id=?",1]).map {|c| [c.category_name, c.id] }
   @language=Language.find(:all)
   end
  def create
    @idcategory = params[:id]
    @picture = Picture.new(params[:picture])
    @product = @picture.build_product(params[:product])
    @product_description=params[:product_description]
    for product_description in @product_description
      @product.product_descriptions << ProductDescription.new(product_description)
    end
    @product. addproductcategory(@idcategory)
    if @picture.save and @product.save
      redirect_to :action=>:show,:controller=>:category,:id=>@idcategory
    end
  end
end
