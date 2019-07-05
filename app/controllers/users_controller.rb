class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :auth_user, only: [:password, :update_password]
  MAX_USERS = 12

  def index
    @users = User.includes(image_attachment: :blob).page(params[:page]).per(MAX_USERS).recent
  end

  def show
    @user = User.find(params[:id])
  end

  def password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to user_path(@user)
    else
      render "password"
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def auth_user
    redirect_back(fallback_location: root_path) if current_user.provider.present?
  end
end
