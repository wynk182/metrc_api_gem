require 'metrc/version'
#require 'dotenv/load'
require 'metrc/configuration'
require 'metrc/error'
require 'metrc/api'
require 'metrc/client'

module Metrc
  extend Configuration

  def self.client(options={})
    Metrc::Client.new(options)
  end

  # Delegate to Metrc::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Metrc::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
