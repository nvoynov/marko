---
title: Marko Readme
keywords:
- ruby
- markup-compiler
...

Marko is a markup compiler that builds a tree from separated sources and compiles it into a single deliverable artifact.

Marko supplies a "docs-as-code" approach for compiling bulky software artifacts by providing source storage, original plain text markup, compiler templates, Ruby- and a command-line interface for assembling and compiling.

Having assembled the artifact, it can be analyzed, enriched by extra data, etc.; it can serve as a source for deriving subdued artifacts.  

I've applied the approach for dozens of artifacts for the last six years, mainly writing requirements in Markdown, analyzing quality, deriving estimation sheets, exporting deliverables with Pandoc, and automating some parts of my everyday work.

## Installation

Install the gem by executing:

    $ gem install marko

## Usage

### Interface

Marko provides just basic command-line interface for creating new projects and assembling artifacts - run `$ marko` to see the details.

In addition to the standard CLI, Marko supplies you with Rakefile, that also serves as custom automation example. You can run `rake -T` to see available commands.

To help you with task automation, Marko provides `Marko.assemble` for assembling and `Marko.compile` for compiling artifacts (you could already spot it inside Rakefile.) See [Automation](#automation) section for examples.

### Structure

`marko new PROJECT` command will create a new Marko project inside the `PROJECT` directory with following structure:

- [bin/](bin/) - output folder for `build`
- [bin/assets/](bin/assets/) - assets folder
- [src/](src/) - markup sources
- [tt/](tt/) - compiler templates
- [marko.yml](marko.yml) - project configuration
- [Rakefile](Rakefile) - Rake automation file
- [README.md](README.md) - this file

### Markup

The basic and the only Marko entity is [TreeNode](#github-link) with `id`, `meta`, `body`, and `items` properties.

And the primary activity is just writing source files consisting of the TreeNode, where the source actually just a regular Markdown with an optional metadata excerpt. All lines from `#` until the next `#` are considered TreeNode.

Let's see it by example and assume one has a few separate sources `content.md`, `uc.signup.md`, and `uc.signin.md`.
`content.md`

```markdown
# Overview
# User Requirements
## Use Cases
{{id: uc, order_index: .signup .signin}}
# Functional requirements
```

`uc.signup.md`

```markdown
# Sign-Up
{{id: .signup, parent: uc}}

body markup
```

`uc.signin.md`

```markdown
# Sign-In
{{id: .signin, parent: uc}}

body markup
```

These sources will be assembled in a single hierarchy as follows

```markdown
# Overview
# User Requirements
## Use Cases
{{id: uc, order_index: .signup .signin}}
### Sign-Up
{{id: .signup, parent: uc}}

body markup
### Sign-In
{{id: .signin, parent: uc}}

body markup

# Functional requirements
```

So all the assemblage magic is just linking TreeNode by using `id`, `parent`, and `order_index` attributes; where `id` and `parent` are just nodes identifiers, and `order_index` is just an array of identifiers that point out the order of getting `items`.

### Metadata

It was shown above how to provide hierarchy attributes by metadata excerpt `{{}}`. But you can also use the excerpt to provide your own attributes, like `source: John Doe`, `affects: some.other.thing`, etc.

### Tree, IDs

When you deal with trees in separated sources, to reference nodes you need identifiers. So when you write `id`, `parent` and `order_index` metadata - you actually deal with TreeNode Id, and it must be unique.  

When one works on a simple parent -> child relationship, identifiers can be shortened by starting from `.`. In the example above `{{order_index: .signup .signin}}`, the parent will find its children by `/.signup$/` and `/.signin$/`; and besides, during the assembling phase those relative identifiers will be turned to full - `uc.signup` and `uc.signin`.

Marko will generate a unique Id for each TreeNode when Id was not provided by the author.

### Macros

The TreeNode.body can include macros. The most helpful one is `[[reference.id]]` that will be substituted by well-formed markdown link `[<node.title>](#<node.url>)`. There are also `@@tree`, `@@list`, `@@todo`, and `@@skip` standard macros; and this list could be extended or shortened through building templates.  

- `@@tree` substituted by the tree of references to all descendants of the current node, might be used for the table of contents;
- `@@list` substituted by the list of references to node items;
- `@@todo` will skip text with the macro till the end of the line
- `@@skip` will skip the text after the macro

### Templates

Marko uses templates placed under the `tt` folder to compile sources into artifacts. You can use and customize the default one or design your own for particular purposes. It's just pure ERB, where Marko renders collection of decorated TreeNodes.

```
% @model.each do |node|
<%= node.text %>
% end
```

The `marko.yml` configuration file sets the building process's default template and other default values.

```yml
title: Artifact
template: tt/default.md.tt
filename: bin/artifact.md
```

### Automation

Following quick example will assemble tree, remove TreeNode with id == 'hint', and compile the tree. You can also see Rakefile for other examples.

```ruby
require 'marko'

def do_remove_hint
  tree = Marko.assemble
  hint = tree.find_node('hint')
  hint.orphan!
  Marko.compile(tree: tree)  
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/marko.
