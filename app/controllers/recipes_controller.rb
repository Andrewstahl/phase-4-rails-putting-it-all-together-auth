class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    user = User.find(session[:user_id])
    if user
      recipes = Recipe.all
      render json: recipes, include: :user, status: :created
    end
  end
  
  def create
    # byebug
    user = User.find(session[:user_id])
    if user
      recipe = user.recipes.create!(recipe_params)
      render json: recipe, include: :user, status: :created
    end
  end

  private

  def recipe_params
    params.permit(:title, :minutes_to_complete, :instructions, :user_id)
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
