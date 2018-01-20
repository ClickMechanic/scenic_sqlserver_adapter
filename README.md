# ScenicSqlserverAdapter

SQL Server adapter for Thoughtbot's [Scenic](https://github.com/thoughtbot/scenic) gem.

SQL Server does not support materialized views or the `CREATE OR REPLACE` statement.  The following methods will raise a `Scenic::Adapters::SqlServer::NotSupportedError`:

`replace_view`, `create_materialized_view`, `refresh_materialized_view`, `update_materialized_view`, `drop_materialized_view`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scenic_sqlserver_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scenic_sqlserver_adapter

## Usage

Configure Scenic to use this adapter:

```
# e.g. config/initializers/scenic.rb

Scenic.configure do |config|
  config.database = Scenic::Adapters::SqlServer.new
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ClickMechanic/scenic_sqlserver_adapter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ScenicSqlserverAdapter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/scenic_sqlserver_adapter/blob/master/CODE_OF_CONDUCT.md).
