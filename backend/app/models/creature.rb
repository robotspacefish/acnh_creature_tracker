class Creature < ApplicationRecord
  has_many :hemispheres

  def self.all_fish
    Creature.where(c_type: "fish")
  end

  def self.all_bugs
    Creature.where(c_type: "bug")
  end

  def set_times
    times = []
    if self.time == "All day"
      times = [0, 23]
    else
      times = time.split(" - ").collect do |t|
        hour, meridiem = t.split(" ")
        if meridiem == "PM"
          hour = hour.to_i + 12
        end
        hour.to_s
      end
    end
    self.update(start_time: times.first, end_time: times.last)
  end

  def self.set_all_creatures_times
    Creature.all.each do |c|
      c.set_times
    end
  end
end