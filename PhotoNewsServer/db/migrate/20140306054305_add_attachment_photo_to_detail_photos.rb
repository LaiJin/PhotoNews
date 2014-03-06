class AddAttachmentPhotoToDetailPhotos < ActiveRecord::Migration
  def self.up
    change_table :detail_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :detail_photos, :photo
  end
end
