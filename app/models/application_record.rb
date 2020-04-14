class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @@months = [nil, "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]

    def months
      @@months
    end

    def current_month
      current_month = Time.now.month
      months[current_month]
    end
end
