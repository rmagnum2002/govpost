class User < ApplicationRecord
  has_many :user_listings
  has_many :listings, through: :user_listings
  has_many :posts

  def name
    full_name
  end
end
