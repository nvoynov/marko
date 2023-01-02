# Purpose
{{parent: intro}}

The main purpose of this document is to provide a comprehensive demo project for Marko gem. The other technical purpose is to have Marko Sandbox for testing and development.

# Problem
{{parent: intro}}

There are a few alternatives for authors who work on bulky software artifacts like requirements specification. They can apply one of the following tools

@@todo find a few popular requirements management tools
@@todo find a few popular Tex alternatives

- a particular requirements management tool, like Doors
- a Word Processor, like Microsoft Word, Libra Office, or Google Docs;
- an elaborate publishing system, like Tex;
- or just using a simple Wiki system, like Confluence or Redmine.

A requirements management tool might seem to be the best choice there because it is tailored exactly for the required process. But it certainly will be a "hard way" from a cost and time perspective, an elaborate and expensive solution requiring personnel to be trained and vendor support.

Although deliverable artifacts could be seen as a usual document structured and expressed in headers and paragraphs, the meaning of each of those can be different. So word processors and wiki systems might be the perfect choice for presenting artifact deliverables, but they lack of semantic fails for content development and management. The best of them provide a scripting language for document processing, but it is usually too complicated and again lacks particular entities' semantics (stakeholders, requirements, constraints, etc.)

Designing documents of hundreds of pages in word processors brings some peculiar drawbacks. The software tends to become "bulky" in operating, consuming too many system resources and responding with delays; tend to be fragile with styles.

__The problem of__ the lack of simple tools and approaches for writing software artifacts __affects__ technical writers who develop and manage the artifacts __the impact of which is__ they tend to choose a publishing tool or a word processor that does not fit well to work on software artifacts causing lots of manual work and maybe other confusing things like "bulky" documents __a successful solution would be__ the tool that will provide

- a plain text markup for writing artifact items, that will be easy to read for humans, and processed by machines;  
- a "semantics" layer to distinguish artifact items (actors, requirements, etc.) from supported text
- the ability to automate tasks based on processing content according to its semantic value;
- the ability to build a convenient presentation of the artifact (pdf, doc, odt);
- will not depend on OS platform and any proprietary format or software.

@@skip

It provides a statement summarizing the problem being solved by the project.

__The problem of__ [describe the problem]
__affects__ [the stakeholders affected by the problem]
__the impact of which is__ [what is the impact of the problem?]
__a successful solution would be__ [list some key benefits of a successful solution]

# Product
{{parent: intro}}

@@todo redesign the product statement for "who" section

__For__ authors of software artifacts __who__ need a reliable and repeatable process of managing big software artifacts __the__ Marko Markup Compiler is a free open source software __that__ brings a "docs-as-code" approach with efficient plain markup for artifact sources, @@todo templates, CLI, Rake ..

@@skip

__For__ [target customer]
__Who__ [statement of the need or opportunity]
__The__ [product name] is a [product category]
__That__ [key benefit, compelling reason to buy]
__Unlike__ [primary competitive alternative]
__Our product__ [statement of primary differentiation]

# Scope
{{parent: intro}}

The developing system will consist of

- the simple plain markup for writing the artifact sources;
- the repository of artifact sources;
- the algorithm for assembling the artifact from sources;
- the markup for templates for publishing the artifact;
- the command line interface for compiling the artifact into deliverables based on the templates  
- the Ruby Gem that presents the artifact as the collection o items that can be easily visited for tasks automation;
- the demo project that will help the customers to adopt the approach and design their own solutions based on the approach.

# Definitions
{{parent: intro}}

CLI

:   Command-line interface

ERB

:   Ruby Templating system

# References
{{parent: intro}}

1. [Markdown Guide](https://www.markdownguide.org/)
2. [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
3. [Git User's Manual](https://git-scm.com/docs/user-manual.html)

# Overview
{{parent: intro}}

The remaining sections of this document provide user- and functional requirements of the system.

The [[usr]] chapter introduces users of the system.

The next chapter [[ur]] introduces users requirements that establish the context for the functional requirements.

The following chapter [[fr]] describes detailed requirements for functions and user interfaces.
