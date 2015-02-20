module Comptaline
  class Exporter
    def initialize
      @entries_buffer = []
    end

    def append(entries)
      @entries_buffer.concat(entries)
    end

    def flush!
      content = CSV.generate(col_sep: ";", row_sep: "\n", encoding: "iso-8859-1") do |csv|
        @entries_buffer.each do |line|
          csv << encode(line)
        end
      end

      { content: content, name: name }
      # Should call client with the result
    end

    def add_customer(customer)
     add_line(customer)
    end

    def add_invoice(invoice)
      add_line(invoice)
    end

    private

    def name
      "COMPTALINE_#{Time.now.strftime("%Y-%m-%d")}.csv"
    end

    def initialize_csv(file)
      CSV.generate(col_sep: ";", row_sep: "\n", encoding: "iso-8859-1")
    end

    def add_line(object)
      buffer.push(object.to_a)
    end

    def encode(values)
      values.map do |value|
        if value.respond_to?(:encode)
          value.encode("iso-8859-1")
        else
          value
        end
      end
    end
  end
end