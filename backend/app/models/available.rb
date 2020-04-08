class Available < ApplicationRecord
  has_many :availables_creatures
  has_many :creatures, through: :availables_creatures
  after_initialize :set_times

  def set_times
    times = []
    if self.time == "All day"
      times = [0, 23]
    else
      if self.time.include?("am") # formatted like: 4am - 7pm
       self.fix_formatting
      end
      split_times = self.time.split(" - ")
      times = split_times.collect do |t|
        hour, meridiem = t.split(" ")

        if meridiem == "PM"
          hour = hour.to_i + 12
        end

        hour
      end
    end
    self.update(start_time: times.first, end_time: times.last)
  end

  def fix_formatting
    times = self.time.upcase.split(" - ")

    times = times.collect do |t|
      t.insert(-3, " ")
    end

    self.update(time: times.join(" - "))
  end

end