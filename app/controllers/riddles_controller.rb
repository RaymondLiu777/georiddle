class RiddlesController < ApplicationController
  before_action :require_login, only: [:new]

  def new
    @riddle = Riddle.new
  end

  def create
    @riddle = Riddle.new(riddle_params)
    @riddle.account_id = session[:account_id]
    if @riddle.save
      redirect_to @riddle
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @riddle = Riddle.find(params[:id])
  end

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
    @riddles = Riddle.all
  end

  private
    def riddle_params
      params.require(:riddle).permit(:title, :description, :visibility)
    end
end
