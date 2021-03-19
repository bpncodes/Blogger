class AddUseridIndexToArticles < ActiveRecord::Migration[6.1]
  def change
    add_index :articles, :user_id
  end
end
