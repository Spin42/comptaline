require "rest-client"
require "uri"
require "csv"

require "comptaline/exporter"
require "comptaline/utils"
require "comptaline/accounting_entry/base"

module Comptaline
  class Configuration
    attr_accessor :host_url, :username, :password
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