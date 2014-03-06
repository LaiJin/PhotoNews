class CreateTitlePhotos < ActiveRecord::Migration
  def change
    create_table :title_photos do |t|
      t.string :title
      t.text :synopsis
      t.string :url

      t.timestamps
    end
  end
end
