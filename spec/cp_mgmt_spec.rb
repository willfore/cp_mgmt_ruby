RSpec.describe CpMgmt do
  client = Faraday.new do |builder|
    builder.adapter :test, @stubs do |stub|
      # CpMgmt Stubs
      stub.post('/web_api/login') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"sid\":\"YxAM8EryQd5rS07VgZ0cXeYDP9CLDQMychNXlLG3wFU\"}}"' ] }
      stub.post('/web_api/keepalive') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"sid\":\"YxAM8EryQd5rS07VgZ0cXeYDP9CLDQMychNXlLG3wFU\"}}"' ] }
      stub.post('/web_api/publish') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/verify-policy') { |env| [ 200, {"policy-package": "standard"}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/verify-policy') { |env| [ 404, {"policy-package": "blah"}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/install-policy') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      # CpMgmt.host stubs
      stub.post('/web_api/add-host') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/delete-host') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-host') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-hosts') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      # CpMgmt.access_rule stubs
      stub.post('/web_api/add-network') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/delete-network') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-network') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-networks') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      # CpMgmt.access_layer stubs
      stub.post('/web_api/add-access-layer') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/delete-access-layer') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-access-layer') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-access-layers') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      # CpMgmt.access_rule stubs
      stub.post('/web_api/add-access-rule') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/delete-access-rule') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-access-rule') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }
      stub.post('/web_api/show-access-rulebase') { |env| [ 200, {}, '"{\"status\":200,\"body\":{\"task-id\":\"01234567-89ab-cdef-a501-0aa75d426e6c\"}}"' ] }

    end
  end

  CpMgmt.configuration.client = client

  it "has a version number" do
    expect(CpMgmt::VERSION).not_to be nil
  end

  it "checks login vars" do
    expect(CpMgmt.configuration.mgmt_server_url).not_to be nil
    expect(CpMgmt.configuration.mgmt_user).not_to be nil
    expect(CpMgmt.configuration.mgmt_pass).not_to be nil
  end

  it "publishes changes" do
    expect(CpMgmt.publish[:status]).to eq :success
  end

  it "installs policy" do
    expect(CpMgmt.install_policy("standard", "someGW")[:status]).to eq :success
  end

  it "verifies policy" do
    expect(CpMgmt.verify_policy("standard")[:status]).to eq :success
    expect(CpMgmt.verify_policy("blah")[:status]).to eq :error
  end

  it "adds a host" do
    expect(CpMgmt.host.add("test", "1.1.1.1")[:status]).to eq :success
  end

  it "removes a host" do
    expect(CpMgmt.host.remove("test")[:status]).to eq :success
  end

  it "shows a host" do
    expect(CpMgmt.host.show("test")[:status]).to eq :success
  end

  it "shows all hosts" do
    expect(CpMgmt.host.show_all[:status]).to eq :success
  end

  it "adds a network" do
    expect(CpMgmt.network.add("test", "1.1.1.0", "255.255.255.0")[:status]).to eq :success
  end

  it "removes a network" do
    expect(CpMgmt.network.remove("test")[:status]).to eq :success
  end

  it "shows a network" do
    expect(CpMgmt.network.show("test")[:status]).to eq :success
  end

  it "shows all networks" do
    expect(CpMgmt.network.show_all[:status]).to eq :success
  end

  it "adds a access_layer" do
    expect(CpMgmt.access_layer.add("test")[:status]).to eq :success
  end

  it "removes a access_layer" do
    expect(CpMgmt.access_layer.remove("test")[:status]).to eq :success
  end

  it "shows a access_layer" do
    expect(CpMgmt.access_layer.show("test")[:status]).to eq :success
  end

  it "shows all access_layers" do
    expect(CpMgmt.access_layer.show_all[:status]).to eq :success
  end

  it "adds a access_rule" do
    expect(CpMgmt.access_rule.add("standard", 5)[:status]).to eq :success
  end

  it "removes a access_rule" do
    expect(CpMgmt.access_rule.remove("standard", 5)[:status]).to eq :success
  end

  it "shows a access_rule" do
    expect(CpMgmt.access_rule.show("standard", 5)[:status]).to eq :success
  end

  it "shows all access_rules" do
    expect(CpMgmt.access_rule.show_rule_base('standard')[:status]).to eq :success
  end

end
