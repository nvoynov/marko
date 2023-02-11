# Generate actors, use cases, and entites from Punch::Domain::DSL
# see [Punch](https://github/nvoynov/punch)
# 
require "optparse"
require "erb"
require "punch"
require "optparse"
require_relative "domain"
require_relative "sampler"
include Punch

@domain = build_domain

parser = OptionParser.new {|cmd|
  cmd.banner = "Usage: ruby marko.rb [OPTIONS]"
  cmd.on('-b DIRECTORY', '--basedir DIRECTORY',
    'Setup base punching directory', String)
  cmd.on('-d', '--dry-run true|false', 'Print result instead of punch', TrueClass)
}

puts "Punch Marko Genearator v0.1"
puts "#{parser}"
options = {}
parser.parse(ARGV, into: options)

nulldir = File.expand_path(__FILE__).sub(/\.rb$/, '')
basedir = options.fetch(:basedir, nulldir)
dryrun  = options.fetch('dry-run'.to_sym, true)

generate = proc{|file, body|
  meth = dryrun == true ? Sampler.method(:preview) : Sampler.method(:write)
  meth.(file, body)
}

samples = Sampler.()
# special case for services, few files
services_source = "fr/uc/%{uc}.md"
services_sample = samples.delete(services_source)
samples.each{|source, sample|
  location = File.join(basedir, source)
  erbsample = sample.match?(/@domain/)
  content = if erbsample
    renderer = ERB.new(sample, trim_mode: "-")
    renderer.result
  else
    sample
  end
  generate.(location, content)
}

# services_source = "fr/uc/%{uc}.md"
# services_sample = samples.delete(service_source)
renderer = ERB.new(services_sample, trim_mode: "-")
@domain.services.each{|model|
  modelstr = model.name.to_s.gsub(/(\s|_)/, '.')
  location = File.join(basedir, services_source % {uc: modelstr})
  @model = model
  generate.(location, renderer.result)
}


__END__

@@sample actors.md
# Actors
{{id: actors, parent: root}}

The system should provide services for the following actors:

@@list

<% @domain.actors.each do |actor| -%>
## <%= actor.name.capitalize %>
{{id: .<%= actor.name.downcase %>}}

<%= actor.desc %>
<% end %>

@@sample fr/uc.md
# Use Cases
{{id: fr.uc, parent: fr}}

@@list

<% @domain.actors.each do |actor| -%>
<%
  order_index = actor.services
    .map(&:name)
    .map(&:to_s)
    .map{ _1.gsub(/(\s|_)/, '.') }
    .map{ _1.split(?.).drop(1).join(?.) }
    .join(' .')
-%>
## <%= actor.name.capitalize %>
{{id: fr.uc.<%= actor.name %>, order_index: .<%= order_index %>}}

The system must provide the following services for <%= actor.name.capitalize %> actor:

@@list

<% end %>

@@sample fr/en.md

# Entities
{{id: .en, parent: fr}}

The system utilises the following entities:

@@list

<% @domain.entities.each do |model| -%>
## <%= model.name.capitalize %>
{{id: .<%= model.name.downcase %>}}

<%= model.desc %>

The entity should provide the following properties:

Property | Type | Multiplicity | Description
-------- | ---- | ------------ | -----------
<% model.params.each do |param| -%>
<%= param.name %> | <%= param.sentry %> | 1 | <%= param.desc %>
<% end -%>

Table: Entity "<%= model.name.capitalize %>"

<% end %>

@@sample fr/uc/%{uc}.md
<%
  dummy = @model.name.to_s.gsub(/(\s|_)/, '.').split(?.).map(&:downcase)
  id = dummy.drop(1).join(?.)
  parent = dummy.first
  header = dummy.drop(1).map(&:capitalize).join(?\s)
-%>
# <%= header %>
{{id: .<%= id %>, parent: fr.uc.<%= parent %>}}

<%= @model.desc %>

**Actors and their Goals**

1. User, wants to get
2. System, wants to ensure

**Guarantee**

[Success]{.underline}

1.
2.

[Failure]{.underline}

1.
2.

**Extend**

- no use case extensions
@@todo - [\[fr.uc]]

**Include**

- no use case inlcusions
@@todo - [\[fr.uc]]

**Main flow**

1.
2.

**Extension**

[1a] something faulty

**Data**

Entities:

@@todo - [\[fr.ent.]];
@@todo - [\[fr.ent.]].
