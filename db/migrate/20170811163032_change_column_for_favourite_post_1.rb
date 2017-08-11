class ChangeColumnForFavouritePost1 < ActiveRecord::Migration[5.1]
  def change
    remove_column :favourite_posts, :user
    remove_column :favourite_posts, :post
    add_column :favourite_posts, :user_id, :integer, index: true
    add_column :favourite_posts, :post_id, :integer, index: true
  end
end
