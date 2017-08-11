class User < ApplicationRecord
  validates :username, presence: {message: "username empty"}
  validates :username, uniqueness: {message: "username exist"}
  validates :password, presence: {message: "password empty"}
  validates :password, length: { minimum:6, message: "password too short"}
  # validate email format
  # to do ...

  has_many :favourite_post_index, class_name: 'FavouritePost', foreign_key: :user_id
  has_many :favourite_posts, through: :favourite_post_index, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :follower_index, class_name: 'FollowerFollowing', foreign_key: :follower_id
  has_many :following_index, class_name: 'FollowerFollowing', foreign_key: :following_id
  has_many :followers, through: :following_index, dependent: :destroy
  has_many :followings, through: :follower_index, dependent: :destroy
end
