class AddAttachmentPhotoToTitlePhotos < ActiveRecord::Migration
  def self.up
    change_table :title_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :title_photos, :photo
  end
end
