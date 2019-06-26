class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.belongs_to :social_network, foreign_key: true
      t.text :external_link

      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :content
  end
end
