class UserIdDeclarations < ActiveRecord::Migration[5.1]
  def change
    add_column :declarations, :user_id, :integer
  end
end
