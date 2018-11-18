module CpMgmt
  class AccessLayer
    # Adds a access-layer
    def add(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/add-access-layer'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # removes a access-layer
    def remove(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/delete-access-layer'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows a access-layer
    def show(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/show-access-layer'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows all access-layers
    def show_all
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      response = client.post do |req|
        req.url '/web_api/show-access-layers'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = "{}"
      end
      CpMgmt.transform_response(response)
    end
  end
end