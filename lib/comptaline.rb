require "rest-client"
require "uri"
require "csv"

require_relative "comptaline/exporter"
require_relative "comptaline/utils"
require_relative "comptaline/accounting_entry/base"
require_relative "comptaline/accounting_entry/general_operation"
require_relative "comptaline/accounting_entry/customer"
require_relative "comptaline/accounting_entry/invoice"
require_relative "comptaline/accounting_entry/clearance"

module Comptaline
  class Configuration
    attr_accessor :host_url, :username, :password, :invoice_journal, :credit_note_journal
  end

  @configuration = Configuration.new

  def self.configure(&block)
    yield(@configuration)
  end

  def self.configuration
    @configuration
  end

  def self.client
    @client ||= Comptaline::Client.new @configuration
  end
end