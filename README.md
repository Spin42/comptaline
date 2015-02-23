# Comptaline

A Comptaline ( http://comptaline.be )

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'comptaline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comptaline

## Usage

Add this in an initializer: 

```
Comptaline.configure do | configuration |
  configuration.host_url            = "https://www.comptamanager.be/app/"
  configuration.username            = "<user>"
  configuration.password            = "<password>"
  configuration.invoice_journal     = "<INVJOURNAL>"
  configuration.credit_note_journal = "<NCJOURNAL>"
end
```

Then create accounting entries and append them to the exporter instance:

```
exporter = Comptaline::Exporter.new

customer               = Comptaline::AccountingEntry::Customer.new
customer.first_name    = "Bob"
customer.id            = 1
exporter.push(customer)

invoice                = Comptaline::AccountingEntry::Invoice.new
invoice.customer_id    = customer_id
invoice.invoice_number = 100
exporter.push(invoice)

exporter.flush!
```

## Contributing

1. Fork it ( https://github.com/spin42/comptaline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request