class AddFkToPostCategories < ActiveRecord::Migration
  def change
  	add_column :post_categories, :user_id, :integer
  	add_column :post_categories, :post_id, :integer
  end
end
