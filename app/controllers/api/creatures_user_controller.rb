 class Api::CreaturesUserController < ApplicationController
  def create
    if !CreaturesUser.find_by(user_id: current_user.id, creature_id: params[:creature][:id] )
      creature_user = CreaturesUser.new(user_id: current_user.id, creature_id: params[:creature][:id])

      if creature_user.save
        render json: UserSerializer.new(current_user).to_serialized_json
      else
        render json: {
          error: "Creature cannot be added"
        }
      end
    else
      render json: {
        error: "Already Owned"
      }
    end
  end

  def destroy
    creature_user = CreaturesUser.find_by(user_id: current_user.id, creature_id: params[:creature][:id]
    )

    if creature_user.destroy
      render json: UserSerializer.new(current_user).to_serialized_json
    else
      render json: {
        error: "Creature was not removed"
      }
    end


  end
end

