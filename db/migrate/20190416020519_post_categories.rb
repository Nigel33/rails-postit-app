class PostCategories < ActiveRecord::Migration
  def change
  	create_table :post_categories do |t|
  		t.timestamps
  	end
  end
end
