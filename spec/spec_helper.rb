require "bundler/setup"
require "cp_mgmt"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

@stubs = Faraday::Adapter::Test::Stubs.new do |stub|
  stub.post('/login') { |env| [200, {}, ''] }
end