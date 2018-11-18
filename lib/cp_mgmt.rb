require "cp_mgmt/version"
require 'faraday'
require 'json'
require 'cp_mgmt/configuration'
require 'cp_mgmt/host'
require 'cp_mgmt/network'
require 'cp_mgmt/access_layer'
require 'cp_mgmt/access_rule'

module CpMgmt
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.host
    @host ||= Host.new
  end
  
  def self.network
    @network ||= Network.new
  end

  def self.access_layer
    @access_layer ||= AccessLayer.new
  end

  def self.access_rule
    @access_rule ||= AccessRule.new
  end

  # Uses the above client to login to the API and set the sid in the env.
  def self.login
    client = self.configuration.client
    body = {user: self.configuration.mgmt_user, password: self.configuration.mgmt_pass}
    response = client.post do |req|
      req.url '/web_api/login'
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end
    ENV.store('sid', JSON.parse(response.body)["sid"])
  end

  # Runs keepalive to stay logged in.
  def self.logged_in?
    client = self.configuration.client

    if ENV.has_key?("sid")
      response = client.post do |req|
        req.url '/web_api/keepalive'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = "{}"
      end
    else
      self.login
    end
  end

  # checks the requests response and produces a predicable map
  def self.transform_response(response)
    if response.status == 200
      {status: :success, body: JSON.parse(response.body)}
    else
      {status: :error, body: JSON.parse(response.body)}
    end
  end

  # publishes provided policy
  def self.publish
    client = self.configuration.client
    self.logged_in?

    response = client.post do |req|
      req.url '/web_api/publish'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = "{}"
    end
    self.transform_response(response)
  end

  # installs provided policy
  def self.install_policy(package, gateways)
    client = self.configuration.client
    self.logged_in?

    body = {"policy-package": package, targets: gateways}
    response = client.post do |req|
      req.url '/web_api/install-policy'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = body.to_json
    end
    self.transform_response(response)
  end

  # verifies provided policy
  def self.verify_policy(package)
    client = self.configuration.client
    self.logged_in?

    body = {"policy-package": package}
    response = client.post do |req|
      req.url '/web_api/verify-policy'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = body.to_json
    end
    self.transform_response(response)
  end
end
