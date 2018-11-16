require "cp_mgmt/version"
require 'faraday'
require 'json'
require 'cp_mgmt/configuration'

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

  # Builds the client for use with all connections
  def self.client
    conn = Faraday.new(:url => self.configuration.mgmt_server_url, :ssl => {:verify => false}) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to $stdout
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn
  end

  # Uses the above client to login to the API and set the sid in the env.
  def self.login
    client = self.client
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
    client = self.client

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

  # publishes provided policy
  def self.publish
    client = self.client
    self.logged_in?

    response = client.post do |req|
      req.url '/web_api/publish'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = "{}"
    end
    {status: response.status, body: JSON.parse(response.body)}
  end

  # installs provided policy
  def self.install_policy
    client = self.client
    self.logged_in?

    body = {"policy-package": package, targets: gateways}
    response = client.post do |req|
      req.url '/web_api/install-policy'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = body.to_json
    end
    {status: response.status, body: JSON.parse(response.body)}
  end

  # verifies provided policy
  def self.verify_policy
    client = self.client
    self.logged_in?

    body = {"policy-package": package}
    response = client.post do |req|
      req.url '/web_api/verify-policy'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-chkp-sid'] = ENV.fetch("sid")
      req.body = body.to_json
    end
    {status: response.status, body: JSON.parse(response.body)}
  end
end
