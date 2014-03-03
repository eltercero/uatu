module Uatu
  module Helper
    def clean_dates(date_from,date_to)
      if Time.parse(date_from) > Time.parse(date_to)
        date_from, date_to = date_to, date_from
      end

      options = Hash.new
      options["dateRange"] = date_from+','+date_to
      options
    end

  end
end
