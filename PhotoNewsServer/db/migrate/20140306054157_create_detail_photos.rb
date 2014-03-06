class CreateDetailPhotos < ActiveRecord::Migration
  def change
    create_table :detail_photos do |t|
      t.integer :title_photo_id, :null => false
      t.text :content
      t.string :url

      t.timestamps
    end
  end
end
