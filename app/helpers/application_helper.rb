# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_builder()
    content = ""
    content << content_tag(:li, content_tag(:a,content_tag(:span,@sort1),:href => "/flower/index",:class =>"top_link"),:class => "top")
    content << content_tag(:li, content_tag(:a,content_tag(:span,@sort2),:href => "/flower/aboutus",:class =>"top_link"),:class => "top")
    content << content_tag(:li, content_tag(:a,content_tag(:span,@sort3),:href => "/flower/newproduct",:class =>"top_link"),:class => "top")

    menu = Category.find_all_by_parent_id(0)
    con = ""
    for item in menu
      submenu = Category.find_all_by_parent_id(item.id)
      if submenu.size > 0
        subcon = ""
        for subitem in submenu
          subcon << content_tag(:li,content_tag(:a, subitem.category_names.find_by_language_id(@idlanguage).category_name,:href => "/flower/category/#{subitem.id}"))
        end
        subcon = content_tag(:ul,subcon)
        subcon << content_tag(:a,item.category_names.find_by_language_id(@idlanguage).category_name,:href => "/flower/category/#{item.id}", :class => "fly")
        con << content_tag(:li,subcon)
      else
        con << content_tag(:li,content_tag(:a, item.category_names.find_by_language_id(@idlanguage).category_name,:href => "/flower/category/#{item.id}"))
      end
      
    end
    con = content_tag(:ul,con, :class => "sub")
    con << content_tag(:a,content_tag(:span, @sort14, :class => "down"), :class => "top_link")
    con = content_tag(:li, con, :class => "top")
    content << con

    content << content_tag(:li, content_tag(:a,content_tag(:span,@sort5),:href => "/customers/new",:class =>"top_link"),:class => "top")
    content << content_tag(:li, content_tag(:a,content_tag(:span,@sort6),:href => "/flower/contact",:class =>"top_link"),:class => "top")
    if logged_in?
      content << content_tag(:li, content_tag(:a,content_tag(:span,@sort4),:href => "/flower/myaccount",:class =>"top_link"),:class => "top")
    end
    if logged_in?
      content << content_tag(:li, content_tag(:a,content_tag(:span,@sort47),:href =>"#{logout_path}",:class =>"top_link"),:class => "top")
    else
      content << content_tag(:li, content_tag(:a,content_tag(:span,@sort46),:href =>"#{login_path}",:class =>"top_link"),:class => "top")
    end

  end
end

