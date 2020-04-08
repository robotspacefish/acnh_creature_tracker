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

  def is_available_at_this_time?
    return true if self.time == "All day"

    # set time instances for start & end times based on current time for comparison
    ct = Time.now
    start_time = Time.new(ct.year, ct.month, ct.day, self.start_time, 0, 0, Time.now.utc_offset)

    # if start time < end time then it goes into the next day
    et_day = self.end_time < self.start_time ? ct.day + 1 : ct.day
    end_time = Time.new(ct.year, ct.month, et_day, self.end_time, 0, 0, Time.now.utc_offset)

    ct.between?(start_time, end_time)
  end

  private
    def fix_formatting
      times = self.time.upcase.split(" - ")

      times = times.collect do |t|
        # start at -3 for index right before am/pm
        t.insert(-3, " ")
      end

      self.update(time: times.join(" - "))
    end

end