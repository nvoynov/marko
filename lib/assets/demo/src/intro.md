# Purpose
{{parent: intro}}

The main purpose of this document is to provide a comprehensive demo project for Marko Gem. The other technical purpose is to have Marko Sandbox for testing and development.

# Problem
{{parent: intro}}

__The problem of__ of managing large structured texts (articles, books, specific structured documents) __affects__ the authors of such texts __the impact of which is__ the text management process itself became a pain as the text groves and the structure evolves __a successful solution would be__ a software that provides

- a simple markup that is easy to write and read by humans and machines
- the ability to manage the text as a bunch of structured separate files
- the ability to publish the text and share it audience
- the ability to collaborate between the authors working together on the text
- the ability to automate some content processing tasks

@@skip

It provides a statement summarizing the problem being solved by the project.

__The problem of__ [describe the problem]
__affects__ [the stakeholders affected by the problem]
__the impact of which is__ [what is the impact of the problem?]
__a successful solution would be__ [list some key benefits of a successful solution]

# Product
{{parent: intro}}

__For__ authors of large structured texts __Who__ need simple reliable text management process __The__ Marko Markup Compiler is a free text management scripting software __That__ utilizes the docs-as-code approach __Unlike__ other competitive approaches like using word processors, Wiki system, or dedicated content publishing systems __Our product__ does not require any special environment and can be adopted in any text environment.

The Marko provides you with:

- the simple markup based on Markdown, extended by tree hierarchy helpers
- the text repository is just a free directory structure inside the file system
- the text tree hierarchy of nodes that present your text pieces
- the ability to automate content processing tasks by providing a scripting layer

Having large structured texts as just a bunch of plain text files, one can

- use any convenient text editor  
- work together with other authors in the Git repository
- use any available text processing tools

# Scope
{{parent: intro}}

The developed system will provide the following components:

- the simple markup format with abilities to build a tree hierarchy
- the markup parser that will turn markup sources into programmable objects
- the markup tree assembler that will build a single tree hierarchy
- the markup tree compiler that will turn the markup tree into deliverables
- the Marko Promo project that will help the users adopt the approach

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

The remaining sections of this document requirements to the system. The document structured the manner of software requirements specification, where one can find descriptions of [[usr]], [[uc]], [[fr]], and [[ui]].
