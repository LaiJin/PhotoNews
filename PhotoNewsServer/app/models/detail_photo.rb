class DetailPhoto < ActiveRecord::Base

  belongs_to :title_photo

  has_attached_file :photo,
                    :styles => { :small => '150x150>'},
                    :url  => '/detailPhoto/:style/:basename.:extension',
                    :path => ':rails_root/public/detailPhoto/:style/:basename.:extension'
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)
  validates_presence_of :content, :title_photo_id

end
