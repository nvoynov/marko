---
title: Marko Changelog
keywords:
- ruby
- markup-compiler
...

## [Unreleased]

## [0.2.4] - 2023-11-21

- changed compiler for using `trim_mode: '%<>'` for ERB
- changed decorator
  - removed `?\n` in `#header`, `#body`
  - changed `#meta` for returning original meta without system keys
  - added `#props` for creating `meta` table
  - added `alias :topic :header`
- changed `tt/artifact.md.tt` for removing extra empty lines
- added `tt/custom.md.tt` as an example of handling custom meta keys
- added test for `tt/*.md.tt`

## [0.2.3] - 2023-11-06

- upgraded for Ruby 3.2
- fixed `assets/init/Rakefile` for lost file extension
- removed extra word from README

## [0.2.2] - 2023-04-14

- changed artifact filename into `bin/artifact.md`; fixed `README.md`
- removed Psych object string from `marko.yml`
- changed `TreeNode#belongs_to?`

## [0.2.0] - 2023-02-11

- added `$ marko samples` that copies samples into `.marko/samples`
- fixed "Marko v0.1.3" error gem version
- changed `$ marko demo`, now it copies demo into `.marko/demo`

## [0.1.0] - 2023-01-02

- Initial release
