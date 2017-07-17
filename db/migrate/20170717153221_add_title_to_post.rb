class AddTitleToPost < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :title, :string
  end

  def down
    remove_column :posts, :title, :string
  end
end
