module Comptaline
  module AccountingEntry
    class GeneralOperation < Base
      attr_accessor :action, :operation_type, :reference, :amount, :date, :communication, :currency_code, 
        :accounting_journal, :match_id, :accounting_writing_number, :index

      def to_a
        [
          @action,                                    
          @operation_type,                                      
          @reference,                                   
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