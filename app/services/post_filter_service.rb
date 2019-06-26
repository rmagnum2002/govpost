# frozen_string_literal: true

class PostFilterService
  def initialize(params = nil, page = 1, per_page = 20)
    @text = params&.[](:text)
    @user_id = params&.[](:user)
    @start_date = params&.[](:start_date)
    @end_date = params&.[](:end_date)
    @listing = params&.[](:listing)
    @social_network = params&.[](:social_network)
    @page = page
    @per_page = per_page
  end

  def call
    if all_params_blank?
      [Post.paginate(page: @page, per_page: @per_page), nil]
    else
      posts = search(
        text: @text,
        user_id: @user_id,
        date_range: date_range,
        listing: @listing,
        social_network: @social_network
      )
      [posts.paginate(page: @page, per_page: @per_page), posts.size]
    end
  end

  def search(text: nil, user_id: nil, date_range: nil, listing: nil, social_network: nil)
    Post.full_text_search(text).
      with_user(user_id).
      with_social_network(social_network).
      created_between(date_range).
      within_users_listing(listing)
  end

  def all_params_blank?
    @text.blank? &&
      @user_id.blank? &&
      date_range.blank? &&
      @listing.blank? &&
      @social_network.blank?
  end

  def date_range
    return if @start_date.blank? || @end_date.blank?
    Date.parse(@start_date).beginning_of_day..Date.parse(@end_date).end_of_day
  end
end
