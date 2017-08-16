class User < ApplicationRecord
  attr_accessor :password_confirmation
  attr_accessor :password

  validates :username, presence: {message: "username empty"}
  validates :username, uniqueness: {message: "username exist"}
  validates :username, length: { maximum: 32, message: "用户名太长"}
  validates :username, format: { with: /\A[a-zA-Z_]+\Z/, message: "用户名包含非法字符" }

  validates :password, presence: {message: "password empty"}
  validates :password, length: { minimum:6, message: "password too short"}
  validates :password, format: { with: /\A[a-zA-Z_]*\Z/, message: "密码包含非法字符"}
  validate :validate_password, on: :create
  before_create :set_password
  before_create :create_avatar
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

  def self.authenticate username, password
    user = User.find_by(username: username)
    if user and user.valid_password? password
      user
    else
      nil
    end
  end

  def valid_password? password
    self.crypted_password == Digest::SHA256::hexdigest(password+self.salt)
  end


  private
  def validate_password
    unless self.password == self.password_confirmation
      self.errors.add(:password_confirmation, "密码不一致")
      return false
    end
    true
  end

  def set_password
    self.salt = Time.new.to_i
    self.crypted_password = Digest::SHA256::hexdigest(self.password+self.salt)
  end

  def create_avatar
    self.avatar_url = LetterAvatar.generate(self.username, 96).gsub('public/', '/')
  end
end

