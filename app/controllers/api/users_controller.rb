class Api::UsersController < ApplicationController
  def index
    users = User.all
    render json: UserSerializer.new(users).to_serialized_json
  end

  def show
    user = User.find_by(id: params[:id])
    render json: UserSerializer.new(user).to_serialized_json
  end

  def create
    user = User.create(user_params)

    if user.save
      session[:user_id] = user.id
      render json: UserSerializer.new(user).to_serialized_json
    else
      render json: {
        error: user.errors
      }
    end
  end

  private
    def user_params
      params.permit(:username, :password, :hemisphere)
    end

end
