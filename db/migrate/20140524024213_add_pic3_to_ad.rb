class AddPic3ToAd < ActiveRecord::Migration
  def change
    add_column :ads, :pic3, :string
  end
end
