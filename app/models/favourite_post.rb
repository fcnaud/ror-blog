class FavouritePost < ApplicationRecord
  belongs_to :follower_user, class_name: 'User', foreign_key: :user_id
  belongs_to :favourite_post, class_name: 'Post', foreign_key: :post_id
end
