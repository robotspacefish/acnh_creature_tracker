class Creature < ApplicationRecord
  has_many :hemispheres
  scope :out_all_day, -> { where(time: "All day") }
  scope :fish, -> { where(c_type: "fish") }
  scope :bugs, -> { where(c_type: "bug") }

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