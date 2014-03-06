class TitlePhoto < ActiveRecord::Base

  has_many :detail_photos

  has_attached_file :photo,
                    :styles => { :small => '150x150>'},
                    :url  => '/titlePhoto/:style/:basename.:extension',
                    :path => ':rails_root/public/titlePhoto/:style/:basename.:extension'
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/png)
  validates_presence_of :title, :synopsis

end
