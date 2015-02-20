module Comptaline
  module AccountingEntry
    class Clearance < GeneralOperation
      def to_a
        [
          action,                                    
          operation_type,                                      
          @payment_id,                                   
          @amount,                
          format_date(@date),
          @communication,                                  
          @currency_code,                           
          @accounting_journal,                                      
          @match_id,                                               
          @accounting_writing_number,                                           
          @index                                                 
        ]
      end

      private

      def action
        "2"
      end

      def operation_type
        "C"
      end 

    end
  end
end