class CreaturesController < ApplicationController
  def index
    creatures = Creature.all
    render  json: CreatureSerializer.new(creatures).to_serialized_json
  end

  def fish
    fish = Creature.fish
    render  json: CreatureSerializer.new(fish).to_serialized_json
  end

  def bugs
    bugs = Creature.bugs
    render  json: CreatureSerializer.new(bugs).to_serialized_json
  end

  def current
    creatures = Creature.available_now
    render json: CreatureSerializer.new(creatures).to_serialized_json
  end
end
