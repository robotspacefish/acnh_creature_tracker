class Creature < ApplicationRecord
  has_many :hemispheres
  has_many :creatures_users
  has_many :users, through: :creatures_users
  has_many :availables_creatures
  has_many :availables, through: :availables_creatures

  scope :out_all_day, -> { where(time: "All day") }
  scope :fish, -> { where(c_type: "fish") }
  scope :bugs, -> { where(c_type: "bug") }
  # scope :info_to_render, ->{ select(:id, :name, :time, :location) }

  scope :sort_by_start_time, -> { order(:start_time) }
  scope :sort_by_start_time_desc, -> { order('start_time DESC') }

  def self.fish_available_now(hemisphere = "north")
    Creature.fish.available_now(hemisphere)
  end

  def self.bugs_available_now(hemisphere = "north")
    Creature.bugs.available_now(hemisphere)
  end

  def is_available_this_month?(hemisphere = "north")
    current_hemisphere = self.hemispheres.find_by('h_type = ?', hemisphere)
    current_month = current_hemisphere.current_month
    current_hemisphere[current_month]
  end

  def is_available_at_this_time?
    current_hour = Time.now.hour
    (self.start_time <= current_hour && self.end_time > current_hour) ||
    # (self.start_time <= current_hour && self.end_time < self.start_time) ||
    (self.start_time >= current_hour && self.end_time < self.start_time)
  end

  def self.available_now(hemisphere = "north")
    Creature.select { |c| c.is_available_this_month?(hemisphere) && c.is_available_at_this_time? }
  end

  # def self.all_out_at(start_time)
  #   # military time
  #   Creature.where(start_time: start_time)
  # end

  # def self.all_out_between(start_time, end_time)
  #   # military time
  #   # TODO >= start_time <= end_time
  #   Creature.where(start_time: start_time, end_time: end_time)
  # end

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
        hour
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