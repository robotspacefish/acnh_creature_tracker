class CreaturesController < ApplicationController
  def index
    creatures = Creature.all
    render  json: creatures
  end

  def fish
    fish = Creature.fish
    render  json: fish
  end

  def current
    creatures = Creature.available_now
    render json: creatures
  end
end
