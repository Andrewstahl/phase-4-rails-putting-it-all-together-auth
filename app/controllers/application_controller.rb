class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorized

  def authorized
    # byebug
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end

end
