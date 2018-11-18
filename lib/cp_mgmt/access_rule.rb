module CpMgmt
  class AccessRule
    # Adds a access-rule
    def add(layer, rule_number, options={})
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?
      params = {layer: layer, "rule-number": rule_number}
      body = params.merge(options).to_json

      response = client.post do |req|
        req.url '/web_api/add-access-rule'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # removes a access-rule
    def remove(rule_number, layer)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {"rule-number": rule_number, layer: layer}.to_json
      response = client.post do |req|
        req.url '/web_api/delete-access-rule'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows a access-rule
    def show(rule_number, layer)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {"rule-number": rule_number, layer: layer}.to_json
      response = client.post do |req|
        req.url '/web_api/show-access-rule'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end

    # Shows all access-rules
    def show_rule_base(name)
      client = CpMgmt.configuration.client
      CpMgmt.logged_in?

      body = {name: name}.to_json
      response = client.post do |req|
        req.url '/web_api/show-access-rulebase'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-chkp-sid'] = ENV.fetch("sid")
        req.body = body
      end
      CpMgmt.transform_response(response)
    end
  end
end