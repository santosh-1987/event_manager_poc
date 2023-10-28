# frozen_string_literal: true

require 'yaml'
require 'rails'

# Class-based hash used to get a service uri for the current environment (test/dev/prod/etc)
#
# Example usage:
# client = Haberdasher::Client.new(ServiceConfig[:haberdasher])
class ServiceConfig
  def self.[](service)
    resp = config[service]
    raise ServiceConfigError, "Error loading config: service '#{service}' not found." if resp.blank?

    resp
  end

  def self.config
    services_file = Rails.root.join('config/services.yml')
    @config = YAML.safe_load(ERB.new(File.read(services_file)).result, aliases: true)[services_env]
                  .with_indifferent_access
  rescue Errno::ENOENT
    raise ServiceConfigError, "Error: 'services.yml' not found."
  end

  # Internal: returns the current service environment based on the command-line parameter
  # and current Rails.env
  # It is the value of the environment variable SERVICES_ENV, if provided
  # Otherwise, it is Rails.env in all others modes except development.
  def self.services_env
    ENV['SERVICES_ENV'] || Rails.env
  end

  # Returns service config hash
  def self.to_h
    {
      open_timeout: ServiceConfig[:open_timeout_default].to_i,
      read_timeout: ServiceConfig[:read_timeout_default].to_i,
      retry_on: ServiceConfig[:retry_on_default],
      retries: ServiceConfig[:retries_default].to_i,
      export_timeout: ServiceConfig[:export_timeout].to_i,
    }.with_indifferent_access
  end
end

# Public: An error indicating an issue related to an interaction with ServiceConfig.
class ServiceConfigError < StandardError
end
