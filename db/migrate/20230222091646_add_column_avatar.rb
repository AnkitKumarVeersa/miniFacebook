class AddColumnAvatar < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :avatar, :text
  end
end
