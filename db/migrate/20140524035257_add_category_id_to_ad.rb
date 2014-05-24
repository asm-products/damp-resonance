class AddCategoryIdToAd < ActiveRecord::Migration
  def change
    add_column :ads, :category_id, :integer
  end
end
