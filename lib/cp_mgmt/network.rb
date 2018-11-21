module CpMgmt
  class Network
    # Adds a network
    def add(name, subnet, subnet_mask, options={})
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?
      params = {name: name, subnet: subnet, "subnet-mask": subnet_mask}
      body = params.merge(options).to_json

      response = client.post do |req|
        req.url '/web_api/add-network'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # removes a network
    def remove(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/delete-network'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows a network
    def show(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/show-network'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows all networks
    def show_all
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      response = client.post do |req|
        req.url '/web_api/show-networks'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = "{}"
      end
      CpMgmt.transform_response(response)
    end
  end
end