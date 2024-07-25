class AddTitleToRiddle < ActiveRecord::Migration[7.1]
  def change
    add_column :riddles, :title, :string
  end
end
