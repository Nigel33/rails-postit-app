class UpdatePostCategories < ActiveRecord::Migration
  def change
  	remove_column :post_categories, :user_id
  	add_column :post_categories, :category_id, :integer
  end
end
