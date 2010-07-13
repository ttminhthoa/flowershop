class Picture < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :torage => :file_system,
                 :max_size => 500.kilobytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' },
                 :path_prefix => "public/images",
                 :partition=>false

  validates_as_attachment
  has_one :partner
  has_one :product

end
