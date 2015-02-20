require "comptaline/accounting_entry/customer"
require "comptaline/accounting_entry/invoicee"
require "comptaline/accounting_entry/general_operation"
require "comptaline/accounting_entry/clearance"

module Comptaline
  module AccountingEntry
    class Base
      def format_date(date)
        date.strftime("%d/%m/%y")
      end
    end
  end
end