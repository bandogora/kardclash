class AddComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :parent_id
      t.integer :user_id
      t.integer :declaration_id
      t.timestamps
    end
  end
end