class Available < ApplicationRecord
  has_many :availables_creatures
  has_many :creatures, through: :availables_creatures
  after_initialize :set_times

  def set_times
    times = []
    if self.time == "All day"
      times = [0, 23]
    else
      # todo account for incorrectly formatted times ex. 4am - 7pm
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
end