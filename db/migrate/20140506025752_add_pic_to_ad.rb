class AddPicToAd < ActiveRecord::Migration
  def change
    add_column :ads, :pic, :string
  end
end
