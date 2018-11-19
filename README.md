# Check Point Management - Ruby

[![CircleCI](https://circleci.com/gh/willfore/cp_mgmt_ruby.svg?style=svg)](https://circleci.com/gh/willfore/cp_mgmt_ruby)

This is a very light wrapper to help simplify working with the Check Point Web API in R80.10 and above. Currently  not all options from the API are available but I plan on adding them going forward. It has been developed using the 1.3 Version of the Check Point Management API. I would recommend using the [API Documentation](https://sc1.checkpoint.com/documents/latest/APIs/index.html#introduction~v1.3%20) as a reference as some of the functions accept an options map. You will need to reference this documentation to discover which options can be passed.

## *Note that this is in very early stages and is being developed on often. I would recommend not running the master branch unless you are willing to expierence outages or behavioral issues.*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cp_mgmt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cp_mgmt

## Setup

Add the following to an initializer. You can create a new one or add it to an exsisting.

```
CpMgmt.configure do |config|
  config.mgmt_server_url = 'https://server.ip'
  config.mgmt_user = 'admin'
  config.mgmt_pass = 'some_password'
end
```

## Usage

Each request returns a hash with command status followed by the request status and body:

Successful:

`{status: :success, body: response_body}`

Error:

`{status: :error, body: response_body}`

Currently this supports the following basic API actions:

- Loging In/Out (This is automatic)
- Hosts `CpMgmt.host`
- Networks `CpMgmt.network`
- Access Layer `CpMgmt.access_layer`
- Access Rules `CpMgmt.access_rule`
- Verify Policy `CpMgmt.verify_policy`
- Install Policy `CpMgmt.install_policy`

Please see the [Wiki](https://github.com/willfore/cp_mgmt_ruby/wiki) for detailed usage and examples.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willfore/cp_mgmt_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the CpMgmt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/willfore/cp_mgmt_ruby/blob/master/CODE_OF_CONDUCT.md).
