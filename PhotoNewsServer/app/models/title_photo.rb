class TitlePhoto < ActiveRecord::Base

  has_many :detail_photos

  has_attached_file :photo,
                    :styles => { :small => '150x150>'},
                    :url  => '/titlePhoto/:style/:basename.:extension',
                    :path => ':rails_root/public/titlePhoto/:style/:basename.:extension'
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)
  validates_presence_of :title, :synopsis

end
