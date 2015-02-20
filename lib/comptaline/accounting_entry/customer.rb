module Comptaline
  module AccountingEntry
    class Customer < Base
      attr_accessor :id, :language_code, :first_name, :last_name, :street, :zipcode, :city, :country_code, :phone_number, :vat_number, :iban, :bic, :email,
        :fax_number, :category, :civility, :company_name, :company_civility

      def to_a
        [
          action,                                        
          @id,                                     
          client_type,                            
          @language_code,                          
          formatted_company_name,                 
          @company_civility,                       
          name,                                   
          @civility,                               
          @category,                               
          @street,                                 
          formatted_zipcode,                      
          @city,                       
          @country_code,                           
          @phone_number,         
          @fax_number,                             
          @vat_number,                             
          @iban,                                   
          @bic,                                    
          @email                            
        ]
      end

      private

      def name 
        "#{@last_name} #{@first_name}"
      end

      def action 
        3
      end

      def client_type
        1
      end

      def formatted_zipcode
         "#{@country_code}-#{@zipcode}"
      end

      def formatted_company_name
        @company_name || name
      end
    end
  end
end