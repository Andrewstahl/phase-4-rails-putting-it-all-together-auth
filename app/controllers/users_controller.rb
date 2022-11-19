class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  skip_before_action :authorized, only: :create

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
    # if user.valid?
    #   session[:user_id] = user.id
    #   render json: user, status: :created
    # else
    #   render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  def show
    user = User.find(session[:user_id])
    if user
      render json: user
    else
      render json: { error: "Unauthorized user" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
