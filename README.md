# Marko

Marko is a markup compiler that builds a tree from separated sources and compiles it into a single deliverable artifact.

Marko supplies a "docs-as-code" approach for compiling bulky software artifacts by providing source storage, original plain text markup, compiler templates, Ruby- and a command-line interface for assembling and compiling.

> __Placing sources under Git__ brings revision management, history of changes, ability to work on artifacts by a few authors simultaneously.

Having the assembled artifact, it can be analyzed, enriched by extra data or data from other artifacts, served as a source for deriving subdued artifacts, etc.  

I've applied the approach for dozens of artifacts for the last six years, mainly writing requirements in Markdown, analyzing quality, deriving estimation sheets, exporting deliverables with Pandoc, and automating some parts of my everyday work.

## Installation

Install the gem by executing:

    $ gem install marko

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/marko.
