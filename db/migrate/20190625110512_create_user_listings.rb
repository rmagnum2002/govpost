class CreateUserListings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_listings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :listing, foreign_key: true

      t.timestamps
    end
  end
end
