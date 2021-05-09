class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :post_image
      t.text :name
      t.integer :category
      t.string :size
      t.text :shop_url
      t.text :caption

      t.timestamps
    end
  end
end
