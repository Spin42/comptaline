module Comptaline
  module AccountingEntry
    class Base
      def format_date(date)
        date.strftime("%d/%m/%y")
      end
    end
  end
end