class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user).to_serialized_json
    else
      render json: {
        error: "Invalid login credentials"
      }
    end
  end

  def get_current_user
    if logged_in?
      render json: UserSerializer.new(current_user).to_serialized_json
    else
      render json: {
        error: "No one logged in"
      }
    end
  end
end
