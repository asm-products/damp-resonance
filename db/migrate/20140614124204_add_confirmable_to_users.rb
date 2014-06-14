class AddConfirmableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmable, :string
  end
end
