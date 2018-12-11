module CpMgmt
  class Configuration
    attr_accessor :mgmt_server_url, :mgmt_user, :mgmt_pass, :mgmt_domain, :client

    def initialize
      @mgmt_server_url = "https://192.168.0.8"
      @mgmt_user = "admin"
      @mgmt_pass = "vpn123"
      @mgmt_domain = nil
      @client = Faraday.new(:url => self.mgmt_server_url, :ssl => {:verify => false}) do |faraday|     
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to $stdout
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end  
    end  
  end
end