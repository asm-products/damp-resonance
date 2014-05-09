class AddAddressfToAds < ActiveRecord::Migration
  def change
    add_column :ads, :address, :string
    add_column :ads, :city, :string
    add_column :ads, :state, :string
    add_column :ads, :zip, :string
  end
end
