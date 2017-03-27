class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :category
      t.string :title
      t.text :description
      t.string :image
      t.decimal :price
      t.boolean :status

      t.timestamps
    end
  end
end
