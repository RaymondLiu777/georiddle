class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= Account.find(session[:account_id]) if session[:account_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action."
      redirect_to login_path
    end
  end

end
