class SocialNetworksController < ApplicationController
  def show
    @network = SocialNetwork.find(params[:id])
  end
end
