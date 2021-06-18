class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :body
      t.integer :user_id
      t.string :name
      t.string :introduction
      t.integer :profile_image_id
      t.timestamps
    end
  end
end
