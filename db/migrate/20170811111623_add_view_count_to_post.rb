class AddViewCountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :view_count, :integer
  end
end
