class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :first_user
      t.integer :second_user
      t.boolean :is_friend
      t.timestamps
    end
  end
end
