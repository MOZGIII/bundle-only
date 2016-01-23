# bundle-only

This gem provides a `bundle-only` command that installs a set of gems listed in specified `Gemfile` group.
Gems are always installed into the system and `Gemfile.lock` is never updated by this command. Though, `Gemfile.lock` is taken into account.

Just call `bundle-only mygroup` and all gems from `group :mygroup` at your `Gemfile` will be installed.

### How it works

This command is designed to be used instead of calling `bundle install --without default development another_group all_not_needed_groups_here` and cleaning `.bundle/config` afterwards (because bundler's `--without` is a *remembered option*).

`bundle-only` is easy to use, does not pollute you bundler configs or augment `Gemfile.lock`, while allowing you to keep all your dependencies versioned in one place.

## Usage

You can install any group from your `Gemfile`:

```ruby
group :development do
  ...
end

# You can create a separate group
group :special do
  gem 'rubocop'
end
```

    $ bundle-only special
    Fetching gem metadata from https://rubygems.org/...........
    Fetching version metadata from https://rubygems.org/..
    Resolving dependencies...
    Using ast 2.2.0
    Using bundler 1.11.2
    Using powerpack 0.1.1
    Using rainbow 2.0.0
    Using ruby-progressbar 1.7.5
    Using parser 2.3.0.1
    Using rubocop 0.36.0
    Bundle complete! 5 Gemfile dependencies, 7 gems now installed.
    Gems in the groups default and development were not installed.

Other example:

```ruby
group :development do
  ...
end

# It will also work if gem is included in multiple groups
group :test, :special do
  gem 'rubocop'
end

group :test do
  ...
end
```

    $ bundle-only special
    Fetching gem metadata from https://rubygems.org/...........
    Fetching version metadata from https://rubygems.org/..
    Resolving dependencies...
    Using ast 2.2.0
    Using bundler 1.11.2
    Using powerpack 0.1.1
    Using rainbow 2.0.0
    Using ruby-progressbar 1.7.5
    Using parser 2.3.0.1
    Using rubocop 0.36.0
    Bundle complete! 5 Gemfile dependencies, 7 gems now installed.
    Gems in the groups default, development and test were not installed.

Notice `test` group is not installed here, but `special` group gems are still installed. You can't have that with bundler's `--with` option and optional groups.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bundle-only'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bundle-only

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MOZGIII/bundle-only.
