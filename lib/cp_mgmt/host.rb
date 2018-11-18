module CpMgmt
  class Host
    # Adds a host
    def add(name, ip_address)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name, "ip-address": ip_address}.to_json
      response = client.post do |req|
        req.url '/web_api/add-host'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # removes a host
    def remove(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/delete-host'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows a host
    def show(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/show-host'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows all hosts
    def show_all
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      response = client.post do |req|
        req.url '/web_api/show-hosts'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = "{}"
      end
      CpMgmt.transform_response(response)
    end
  end
end