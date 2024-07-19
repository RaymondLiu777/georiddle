class AccountsController < ApplicationController
  before_action :require_login, only: [:show]

  def new 
    @account = Account.new
  end

  def create 
    @account = Account.new(account_params)
    
    if @account.save
      session[:account_id] = @account.id
      redirect_to @account, notice: "Account was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @account = Account.find(params[:id])
  end

  private
    def account_params()
      params.require(:account).permit(:username, :password, :password_confirmation)
    end
end
