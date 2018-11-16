# Check Point Management - Ruby

This is a very light wrapper to help simplify working with the Check Point Web API in R80.10 and above. Currently  not all options from the API are available but I plan on adding them going forward. It has been developed using the 1.3 Version of the Check Point Management API. I would recommend using the [API Documentation](https://sc1.checkpoint.com/documents/latest/APIs/index.html#introduction~v1.3%20) as a reference as some of the functions accept an options map. You will need to reference this documentation to discover which options can be passed.

## *Note that this is in very early stages and is being developed on often. I would recommend not running the master branch unless you are willing to expierence outages or behavioral issues.*

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/cp_mgmt`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cp_mgmt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cp_mgmt

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cp_mgmt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CpMgmt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cp_mgmt/blob/master/CODE_OF_CONDUCT.md).
