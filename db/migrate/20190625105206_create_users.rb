class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name

      t.timestamps
    end

    add_index :users, :full_name
  end
end
