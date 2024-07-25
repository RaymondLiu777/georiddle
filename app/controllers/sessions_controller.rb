class SessionsController < ApplicationController
  def new
    if session[:account_id].present?
      redirect_to root_path
    end
  end

  def create
    account = Account.find_by(username: params[:session][:username])
    if account && account.authenticate(params[:session][:password])
      session[:account_id] = account.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_path
    else
      puts "Failed Login"
      flash.now[:alert] = "There was something wrong with your login details."
      render :new, status: :bad_request
    end
  end

  def destroy
    session[:account_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
