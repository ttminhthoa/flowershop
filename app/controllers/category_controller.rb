class CategoryController < ApplicationController
  layout "admin"
   before_filter  :adminlogin_required
  def listcategories
    @categories = Category.find(:all)
  end
  def new
    @category_name = CategoryName.new
    @language=Language.find(:all)
  end
  def create
    @category = Category.new(params[:category])
    @abc = params[:category_name]
    for name in @abc 
      @category.category_names << CategoryName.new(name)
    end
    if @category.save
      redirect_to :action=>:listcategories,:controller=>:category
    else
      render :text=>"Ko insert duoc"
    end
  end
 
  def edit
   @category= Category.find(params[:id])
   @categoryname = @category.category_names
   @category_name = CategoryName.new
   @language=Language.find(:all)
  end
  def update
    CategoryName.update(params[:category_name].keys, params[:category_name].values)
    redirect_to :action=>:listcategories,:controller=>:category
    end
  def show
    #@idcategory = params[:idcategory]
    @category = Category.find(params[:id])
    @categories=@category.category_names
    @products = @category.products.paginate :page => params[:page], :per_page => 6
  end
  def destroy
    @category=Category.find(params[:id])
    @categoryname=@category.category_names
    if @category.destroy 
      for categoryname in @categoryname
        categoryname.destroy
      end
      redirect_to :action=>:listcategories,:controller=>:category 
    else
      render :text=>"Xóa không thành công"
    end
  end
  def moveto
    @idproduct=params[:id]
    @idcategory=params[:idcategory]
    @categories_product = Product.find(@idproduct).categories.find(@idcategory)
    @categories = CategoryName.find(:all, :order => "category_name",:conditions=>["language_id=?",1]).map {|c| [c.category_name, c.category_id] }
end
  def copyto
    @idproduct=params[:id]
    @idcategory=params[:idcategory]
    @categories = CategoryName.find(:all, :order => "category_name",:conditions=>["language_id=?",1]).map {|c| [c.category_name, c.category_id] }
  end
  def copy
      @categoriesproduct= CategoriesProduct.new(params[:categories_product])
      if @categoriesproduct.save
        redirect_to :action=>:listcategories,:controller=>:category
      end
  end
  def move
    @idproduct=params[:idproduct]
    @idcategory=params[:idcategory]
    #@categoryproduct = CategoriesProduct.find(:first,:conditions=>["product_id=? and category_id=?",@idproduct,@idcategory])
    #if CategoriesProduct.delete_all("product_id=#{@idproduct} and category_id=#{@idcategory}")
     # @categoryproduct = CategoriesProduct.new (params[:categories_product])
     # if @categoryproduct.save
     #   redirect_to :action=>:listcategories,:controller=>:category
    #  end
   # end
   if CategoriesProduct.update_all("category_id=#{params[:categories_product][:category_id]}","product_id=#{@idproduct} and category_id = #{@idcategory}")
     redirect_to :action=>:listcategories,:controller=>:category
   end
  end
end
