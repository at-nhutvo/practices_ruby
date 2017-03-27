class AddColumBook < ActiveRecord::Migration[5.0]
  def change
  	add_column :books, :view, :integer, default: 0
  end
end
