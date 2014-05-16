class AddPic2ToAd < ActiveRecord::Migration
  def change
    add_column :ads, :pic2, :string
  end
end
