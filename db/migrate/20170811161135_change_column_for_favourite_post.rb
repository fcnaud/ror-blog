class ChangeColumnForFavouritePost < ActiveRecord::Migration[5.1]
  def change
    remove_column :favourite_posts, :favourite_id_id
    remove_column :favourite_posts, :psot_id_id
    add_column :favourite_posts, :user, :belongs_to, index: true
    add_column :favourite_posts, :post, :belongs_to, index: true
  end
end
