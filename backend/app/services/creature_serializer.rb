class CreatureSerializer
  def initialize(creature_object)
    @creature = creature_object
  end

  def to_serialized_json
    options = {
      except: [:image_url, :url],
      include: [:hemispheres, :availables]
    }

    @creature.to_json(options)
  end
end