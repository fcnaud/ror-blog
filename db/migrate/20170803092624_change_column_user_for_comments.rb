class ChangeColumnUserForComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :user
    add_column :comments, :user_id, :integer
  end
end
