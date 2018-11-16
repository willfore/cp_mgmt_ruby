require "cp_mgmt/version"

module CpMgmt
  class Error < StandardError; end

  # setup for all API queries  
ENV.store('mgmt_server_url', "https://192.168.0.8:443")
ENV.store('mgmt_user', "admin")
ENV.store('mgmt_pass', "vpn123")

end
