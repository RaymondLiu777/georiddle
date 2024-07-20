class CreateRiddles < ActiveRecord::Migration[7.1]
  def change
    create_table :riddles do |t|
      t.text :description
      t.references :account, null: false, foreign_key: true
      t.string :visibility

      t.timestamps
    end
  end
end
