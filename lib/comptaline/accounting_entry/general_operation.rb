module ComptalineClient
  module AccountingEntry
    class GeneralOperation < AccountingEntry::Base
      attr_accessor :action, :operation_type, :payment_id, :amount, :date, :communication, :currency_code, 
        :accounting_journal, :match_id, :accounting_writing_number, :index

      def to_a
        [
          @action,                                    
          @operation_type,                                      
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
    end
  end
end