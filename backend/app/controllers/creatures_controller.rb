class CreaturesController < ApplicationController
  def index
    creatures = Creature.all
    render  json: creatures
  end

  def fish
    fish = Creature.where(c_type: "fish")
    render  json: fish
  end
end
