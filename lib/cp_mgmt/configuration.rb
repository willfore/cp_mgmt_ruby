module CpMgmt
    class Configuration
    attr_accessor :mgmt_server_url, :mgmt_user, :mgmt_pass

    def initialize
      @mgmt_server_url = "https://192.168.0.8"
      @mgmt_user = "admin"
      @mgmt_pass = "vpn123"
    end
  end
end