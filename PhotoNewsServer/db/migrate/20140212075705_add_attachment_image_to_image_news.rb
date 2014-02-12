class AddAttachmentImageToImageNews < ActiveRecord::Migration
  def self.up
    change_table :image_news do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :image_news, :image
  end

end
