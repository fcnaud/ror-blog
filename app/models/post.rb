class Post < ApplicationRecord
  has_many :favourite_post_index, class_name: 'FavouritePost', foreign_key: :post_id
  has_many :follower_users, through: :favourite_post_index, dependent: :destroy

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

end
