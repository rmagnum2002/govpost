# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts, @size = PostFilterService.new(
      params[:search], params[:page]
    ).call
  end
end
