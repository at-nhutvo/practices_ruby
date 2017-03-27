class AddIndexBook < ActiveRecord::Migration[5.0]
  def change
  	add_index :books, :category
  end
end
