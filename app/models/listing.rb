class Listing < ApplicationRecord
  has_many :user_listings
  has_many :users, through: :user_listings

  def posts
    Post.where(user_id: users.pluck(:id))
  end
end
