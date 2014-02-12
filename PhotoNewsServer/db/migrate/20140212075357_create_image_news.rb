class CreateImageNews < ActiveRecord::Migration
  def change
    create_table :image_news do |t|
      t.text :content
      t.string :image_url

      t.timestamps
    end
  end
end
