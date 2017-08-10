class CreateFollowerFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :follower_followings do |t|
      t.belongs_to :follower, index: true  # 关注者
      t.belongs_to :following, index: true  # 被关注
      t.timestamps
    end
  end
end
