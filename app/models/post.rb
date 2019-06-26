# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_full_text,
                  against: %i[content title],
                  using: {
                    tsearch: { any_word: true }
                  }
  belongs_to :user
  belongs_to :social_network

  scope :with_user, lambda { |user_id|
    where('posts.user_id = ?', user_id) if user_id.present?
  }

  scope :with_social_network, lambda { |social_network_id|
    where('posts.social_network_id = ?', social_network_id) if social_network_id.present?
  }

  scope :created_between, lambda { |date_range|
    where(created_at: date_range) if date_range.present?
  }

  scope :within_users_listing, lambda { |listing_id|
    if listing_id.present?
      joins(
        "INNER JOIN user_listings ON user_listings.user_id = posts.user_id AND user_listings.listing_id = #{listing_id}"
      )
    end
  }

  def self.full_text_search(text)
    return all if text.blank?

    search_full_text(text)
  end
end
