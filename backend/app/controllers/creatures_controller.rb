class CreaturesController < ApplicationController
  def index
    creatures = Creature.all
    render  json: creatures
  end

  def fish
    fish = Creature.all_fish
    render  json: fish
  end
end
