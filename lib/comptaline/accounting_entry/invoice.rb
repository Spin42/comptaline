module Comptaline
  module AccountingEntry
    class Invoice < Base
      attr_accessor :customer, :is_credit_note, :date, :due_date, :invoice_number, :communication, :structured_communication, :account_assignment,
        :vat_code, :amount, :amount_with_vat, :vat_amount, :currency_code, :match_id

      def initialize(type = {})
        @is_credit_note = type[:is_credit_note] == true
      end

      def to_a
        [
          action,                                        
          @customer.id,                  
          journal,                               
          period,        
          invoice_number,                 
          format_date(@date),
          format_date(@due_date),
          @communication,                               
          @structured_communication,
          account_assignment,              
          vat_code,                           
          @amount,                         
          @vat_amount,                                      
          @amount_with_vat,                       
          @currency_code,                                
          @match_id,                             
          credit_note_flag                       
        ]
      end

      def vat_code
        return @vat_code unless @vat_code.nil?
        vat_codes[invoice_type]
      end

      def account_assignment
        return @account_assignment unless @account_assignment.nil?
        account_assignments[invoice_type]
      end

      private

      def action
        1
      end

      def journal
        if @is_credit_note
          Comptaline.configuration.credit_note_journal
        else
          Comptaline.configuration.invoice_journal
        end
      end

      def credit_note_flag
        @is_credit_note ? 1 : 0
      end

      def period
        @date.strftime("%m")
      end

      def invoice_type 
        if !Comptaline.configuration.invoicer_subject_to_vat
          :invoicer_not_subject_to_vat
        elsif @customer.country_code == "BE"
          :belgian_customer
        elsif @customer.vat_number
          :european_business_customer
        elsif vat_codes_for_european_individual_customers[@customer.country_code]
          :european_individual_customer
        else
          :non_european_customer
        end
      end

      def account_assignments
        {
          invoicer_not_subject_to_vat:   "702100",
          belgian_customer:              "702100",
          european_business_customer:    "700001",
          european_individual_customer:  "700003",
          non_european_customer:         "700002"
        }
      end

      def vat_codes
        {
          invoicer_not_subject_to_vat:   "211100",
          belgian_customer:              "211400",
          european_business_customer:    "222000",
          european_individual_customer:  vat_codes_for_european_individual_customers[@customer.country_code],
          non_european_customer:         "232000"
        }
      end

      def vat_codes_for_european_individual_customers
        {
          "AT" => "224100",
          "BG" => "225500",
          "BE" => "211400",
          "CY" => "224600",
          "DE" => "232002",
          "DK" => "223100",
          "ES" => "223300",
          "EE" => "224500",
          "FI" => "224300",
          "FR" => "223405",
          "GR" => "223200",
          "UK" => "223500",
          "HU" => "224900",
          "IE" => "223600",
          "IT" => "223700",
          "LV" => "224700",
          "LT" => "224800",
          "LU" => "223800",
          "MT" => "225000",
          "NL" => "223902",
          "PL" => "225100",
          "PT" => "224000",
          "RO" => "225400",
          "SK" => "225300",
          "SI" => "225200",
          "SE" => "224200",
          "CZ" => "224400",
          "HR" => "225600"
        }
      end
    end
  end
end