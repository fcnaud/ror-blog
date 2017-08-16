class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags, dependent: :destroy

  validates :name, presence: {message: "empty"}
  validates :name, uniqueness: {message: "exist"}
  validates :name, length: {maximum: 32, message: "too long"}
end
