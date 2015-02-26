module Comptaline
  class Exporter
    def initialize
      @entries_buffer = []
    end

    def concat(entries)
      @entries_buffer.concat(entries)
    end

    def push(entry)
      @entries_buffer.push(entry)
    end

    def flush!(options = {})
      return "" unless @entries_buffer.size > 0

      csv = CSV.generate(col_sep: ";", row_sep: "\n", encoding: "iso-8859-1") do |csv|
        @entries_buffer.each do |entry|
          csv << encode(entry.to_a)
        end
      end
      Comptaline.client.send(csv) if options[:send] == true
      csv
    end

    def add_customer(customer)
     add_line(customer)
    end

    def add_invoice(invoice)
      add_line(invoice)
    end

    private

    def add_line(object)
      buffer.push(object.to_a)
    end

    def encode(values)
      values.map do |value|
        if value.respond_to?(:encode)
          value.encode("iso-8859-1").gsub(/["']/, " ")
        else
          value
        end
      end
    end
  end
end