class Creature < ApplicationRecord
  has_many :hemispheres
  has_many :creatures_users
  has_many :users, through: :creatures_users

  scope :out_all_day, -> { where(time: "All day") }
  scope :fish, -> { where(c_type: "fish") }
  scope :bugs, -> { where(c_type: "bug") }

  def self.all_out_at(start_time)
    # military time
    Creature.where(start_time: start_time)
  end

  def self.all_out_between(start_time, end_time)
    # military time
    # TODO >= start_time <= end_time
    Creature.where(start_time: start_time, end_time: end_time)
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