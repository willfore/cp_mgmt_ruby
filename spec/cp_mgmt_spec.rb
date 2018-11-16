RSpec.describe CpMgmt do
  it "has a version number" do
    expect(CpMgmt::VERSION).not_to be nil
  end

  it "checks login vars" do
    expect(CpMgmt.configuration.mgmt_server_url).not_to be nil
    expect(CpMgmt.configuration.mgmt_user).not_to be nil
    expect(CpMgmt.configuration.mgmt_pass).not_to be nil
  end
end
