class ChangColumnSoltForUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :solt, :salt
  end
end
