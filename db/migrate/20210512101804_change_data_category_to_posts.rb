class ChangeDataCategoryToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :category, :string
  end
end
