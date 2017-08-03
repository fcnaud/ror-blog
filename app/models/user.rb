class User < ApplicationRecord
  validates :username, presence: {message: "username empty"}
  validates :username, uniqueness: {message: "username exist"}
  validates :password, presence: {message: "password empty"}
  validates :password, length: { minimum:6, message: "password too short"}
  # validate email format
  # to do ...

  has_many :comments
end
