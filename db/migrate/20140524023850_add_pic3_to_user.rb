class AddPic3ToUser < ActiveRecord::Migration
  def change
    add_column :users, :pic3, :string
  end
end
