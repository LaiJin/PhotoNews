class DetailPhoto < ActiveRecord::Base

  belongs_to :title_photo

  has_attached_file :photo,
                    :url  => '/detailPhoto/:style/:basename.:extension',
                    :path => ':rails_root/public/detailPhoto/:style/:basename.:extension'
  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/png)
  #validates_presence_of :content, :title_photo_id

end
