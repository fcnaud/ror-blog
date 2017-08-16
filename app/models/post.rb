class Post < ApplicationRecord
  has_many :favourite_post_index, class_name: 'FavouritePost', foreign_key: :post_id
  has_many :follower_users, through: :favourite_post_index, dependent: :destroy

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :post_tags
  has_many :tags, through: :post_tags, dependent: :destroy

  validates :title, presence: true

end
