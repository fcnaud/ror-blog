class CreateFavouritePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :favourite_posts do |t|
      t.belongs_to :favourite_id, index: true
      t.belongs_to :psot_id, index: true

      t.timestamps
    end
  end
end
