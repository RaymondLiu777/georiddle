class RiddlesController < ApplicationController
  before_action :require_login

  def index
    if params[:latitude].present? && params[:longitude].present?
      @location = {
        latitude: params[:latitude],
        longitude: params[:longitude],
      }
    end
  end
end
