class AddDescriptionToDeclarations < ActiveRecord::Migration[5.1]
  def change
    add_column :declarations, :description, :text
    add_column :declarations, :created_at, :datetime
    add_column :declarations, :updated_at, :datetime
  end
end
