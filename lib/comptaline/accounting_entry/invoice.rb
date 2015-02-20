module Comptaline
  module AccountingEntry
    class Invoice < AccountingEntry::Base
      attr_accessor :customer_id, :is_credit_note, :date, :due_date, :invoice_number, :communication, :structured_communication, :inputation_account,
        :vat_code, :amount, :amount_with_vat, :vat_amount, :currency_code, :match_id

      def initialize(type)
        @is_credit_note = type[:is_credit_note] = false
      end

      def to_a
        [
          action,                                        
          @customer_id,                  
          journal,                               
          period,        
          invoice_number,                 
          format_date(@date),
          format_date(@due_date),
          @communication,                               
          @structured_communication,
          @imputation_account,              
          @vat_code,                           
          @amount,                         
          @vat_amount,                                      
          @amount_with_vat,                       
          @currency_code,                                
          @match_id,                             
          credit_note_flag                       
        ]
      end

      private

      def action
        1
      end

      def journal
        @is_credit_note ? invoice_journal : credit_note_journal
      end

      def invoice_journal
        ComptalineClient.configuration.journals.invoices
      end

      def credit_note_journal
        ComptalineClient.configuration.journals.credit_notes
      end

      def credit_note_flag
        @is_credit_note ? 1 : 0
      end

      def period
        @created_at.strftime("%m")
      end

    end
  end
end