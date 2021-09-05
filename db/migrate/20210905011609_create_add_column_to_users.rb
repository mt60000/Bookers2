class CreateAddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :add_column_to_users do |t|
      t.integer :entry

      t.timestamps
    end
  end
end
