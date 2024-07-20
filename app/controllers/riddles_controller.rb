class RiddlesController < ApplicationController
  before_action :require_login

  def index
    if params[:latitude].present? && params[:longitude].present?
      geolocation = Geocoder.search([params[:latitude], params[:longitude]])
      puts geolocation.inspect
      @location = {
        latitude: params[:latitude],
        longitude: params[:longitude],
        address: geolocation.first.address
      }
    end
  end
end
