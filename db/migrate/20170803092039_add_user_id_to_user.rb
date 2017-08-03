class AddUserIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :user, :reference
  end
end
