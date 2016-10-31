require 'holidays'

module ACH
  class NextFederalReserveEffectiveDate
    attr_accessor :query_date

    def initialize(query_date)
      @query_date = query_date
    end

    def result
      @result ||= parse_result
    end

    private

    def parse_result
      date = query_date
      begin
        date = date.next_day
      end while weekend?(date) || holiday?(date)
      date
    end

    def weekend?(date)
      date.saturday? || date.sunday?
    end

    def holiday?(date)
      Holidays.on(date, :federal_reserve).any?
    end
  end
end
