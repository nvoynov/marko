% Artifact

# Intro {#intro}

## Purpose {#intro-01}

The main purpose of this document is to provide a comprehensive demo project for Marko Gem. The other technical purpose is to have Marko Sandbox for testing and development.

## Problem {#intro-02}

__The problem of__ of managing large structured texts (articles, books, specific structured documents) __affects__ the authors of such texts __the impact of which is__ the text management process itself became a pain as the text groves and the structure evolves __a successful solution would be__ a software that provides

- a simple markup that is easy to write and read by humans and machines
- the ability to manage the text as a bunch of structured separate files
- the ability to publish the text and share it audience
- the ability to collaborate between the authors working together on the text
- the ability to automate some content processing tasks

## Product {#intro-03}

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

## Scope {#intro-04}

The developed system will provide the following components:

- the simple markup format with abilities to build a tree hierarchy
- the markup parser that will turn markup sources into programmable objects
- the markup tree assembler that will build a single tree hierarchy
- the markup tree compiler that will turn the markup tree into deliverables
- the Marko Promo project that will help the users adopt the approach

## Definitions {#intro-05}

CLI

:   Command-line interface

ERB

:   Ruby Templating system

## References {#intro-06}

1. [Markdown Guide](https://www.markdownguide.org/)
2. [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
3. [Git User's Manual](https://git-scm.com/docs/user-manual.html)

## Overview {#intro-07}

The remaining sections of this document requirements to the system. The document structured the manner of software requirements specification, where one can find descriptions of [Users](#usr), [Use Cases](#uc), [Functional Requirements](#fr), and [Interface Requirements](#ui).

# Users {#usr}

The users of the system are different people who play for authoring various sorts of technical documentation. It might be a technical writer, business/systems analyst, developer, etc.

# User Requirements {#ur}

------ --
__Id__ ur
------ --

## Use Cases {#uc}

------ --
__Id__ uc
------ --

### Create a new project {#uc-create}

------ ---------
__Id__ uc.create
------ ---------

The scenario is used when the user wants to create a new Marko artifact project

__Main Flow__

1. The user requests the system to create a new project passing the directory name for the project.
2. The system checks the directory does not exist; directory des not exist.
3. The system creates the directory and furnish it with basic Marko structure.
4. The system reports to the user about created directories and files.
5. The scenario is finished

__Extensions__

[2a]{.underline} The directory exists: The system reports to the user that the directory exits. The scenario if finished.

### Manage artifact sources {#uc-manage}

------ ---------
__Id__ uc.manage
------ ---------

[Outside the system]{.underline} scenario of managing the artifact sources, templates, automated tasks.

__Main Flow__

[Outside the system]{.underline}

1. The user creates, modifies, removes markup files inside `src` directory of Marko project (created by [Create a new project](#uc-create) scenario.)
2. The user creates, modifies, removes templates for the artifact compilation.
3. The user creates, modifies, removes automation tasks.

### Compile artifact {#uc-compile}

------ ----------
__Id__ uc.compile
------ ----------

The scenario is used when the user wants to compile the artifact from the artifact sources

__Prerequisites__

1. The user inside Marko project (see [Create a new project](#uc-create))

__Main Flow__

1. The user requests the system to compile the project sources into the artifact passing compilation template.
2. The system read the artifact sources and assembles it into the artifact tree; no errors detected.
3. The system compiles the artifact tree into single artifact using provided template.
4. The system reports compiled artifact filename to the user.
5. The scenario is finished.  

__Extensions__

[2a]{.underline} The system detected markup errors inside sources: The system reports the errors found to the user; the scenario is finished.

[2b]{.underline} The system detected tree structure errors during the assembling stage: The system reports the errors found to the user; the scenario is finished.

### Automate tasks {#uc-automate}

------ -----------
__Id__ uc.automate
------ -----------

Basically, Marko assembles artifacts from markup sources, but there are cases when user wants to add some information from other sources like UI/UML/ER design tools, some prepared data files in whatever it could be form. Sometimes the user wants to modify or remove some content inside the markup sources.

Such tasks could be automated by intervening into the artifact tree between assemblage and compilation stages.

__Main Flow__

1. The user design one or more automation scripts
2. The user injects the automation scripts into compilation process

# Functional Requirements {#fr}

------ --
__Id__ fr
------ --

## TreeNode {#fr-treenode}

------ -----------
__Id__ fr.treenode
------ -----------

The system shall provide `Node` entity with the following properties that provide the following attributes:

Property  Type     Mult. Default Description
--------- -------- ----- ------- -----------
id        String       1    ""      Node identifier
parent    Node         1    null    Parent node
title     String       1    ""      Node title
meta      Hash         1    {}      Node metadata
body      String       1    ""      Node body
items     TreeNode  0..N    []      Child nodes

### Tree Metadata {#fr-treenode-tree}

------ ----------------
__Id__ fr.treenode.tree
------ ----------------

To assemble the project artifact from nodes placed among several source files, the system shall provide the following optional tree metadata attributes:

Attribute   Type   Mult. Description
----------- ------ ----- --------------
id          String  0..1 Unique node id
parent      String  0..1 Parent id
order_index String  0..N Children IDs

### Source Metadata {#fr-treenode-orig}

------ ----------------
__Id__ fr.treenode.orig
------ ----------------

During source file parsing, the system must store the following node origin information:

Attribute   Type   Mult. Description
----------- ------ ----- --------------
origin      String     1 file name
lineno      String     1 file line

## Source Markup {#fr-markup}

------ ---------
__Id__ fr.markup
------ ---------

The main and only entity in the system is [TreeNode](#fr-treenode). The system shall provide the following abilities for the entity:

- [Node Markup](#fr-markup-node)
- [Get Sources](#fr-markup-01)
- [Parse Source](#fr-markup-02)
- [Assemble Tree](#fr-markup-03)
- [Inject Id](#fr-markup-04)
- [Checking Tree](#fr-markup-05)

### Node Markup {#fr-markup-node}

------ --------------
__Id__ fr.markup.node
------ --------------

The system shall support the following node markup.

```markdown
# <title>
{{\<meta\>}}
\<body\>
```

Where:  

- Each node starts from Markdown header mark `#`.
- The header mark can be followed by node title.
- The next line _might_ contain metadata block:
   - that starts from `{{` and finishes with `}}`;
   - that can be one or multiline string.
- The next lines tile the end of file or next header mark `#` are considered as node body.

### Get Sources {#fr-markup-01}

------ ------------
__Id__ fr.markup.01
------ ------------

The system shall provide function to getting all sources files from project repository.

### Parse Source {#fr-markup-02}

------ ------------
__Id__ fr.markup.02
------ ------------

The system shall provide the function to parse source file.

During the parsing process the system must record source information within the node parsed, such as origin file name and the number of line inside the origin where the node begins. This information must be stored inside metadata as [Source Metadata](#fr-treenode-orig).

__Input__

Parameter | Type   | Mult. | Description
--------- | ------ | ----- | -----------
filename  | String |     1 | filename

__Output__

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | -----------
node      | [TreeNode](#fr-treenode) | 0..N  | node parsed

### Assemble Tree {#fr-markup-03}

------ ------------
__Id__ fr.markup.03
------ ------------

The system shall provide the function to assemble the artifact tree. The artifact tree is assembled based on [Tree Metadata](#fr-treenode-tree).



__Input__

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | -----------
node      | [TreeNode](#fr-treenode) | 0..N  | node collection

__Output__

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | -----------
node      | [TreeNode](#fr-treenode) |    1  | root node

### Inject Id {#fr-markup-04}

------ ------------
__Id__ fr.markup.04
------ ------------

The system shall provide each node with unique node Id. Some nodes can already have id from source files, especially those that referenced as parent or child and placed in separate files. For those nodes that still have empty id, the system must generate auto id 0..99.

For example, when the system has assembled the tree

```markdown
# Artifact
## Introduction
### Purpose
### Scope
# User Requirements #ur
# Functional Requirements #fr
```

and then generated id, the generated ids should be as follows:

```markdown
# Artifact Title #00
## Introduction #01.01
### Purpose #01.01.01
### Scope #01.01.02
# User Requirements #ur
# Functional Requirements #fr
```

__Input__

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | -----------
root      | [TreeNode](#fr-treenode) |    1  | root node

### Checking Tree {#fr-markup-05}

------ ------------
__Id__ fr.markup.05
------ ------------

The system shall provide the function to check assembled tree for errors related to assembling tree based on [Tree Metadata](#fr-treenode-tree). The system must check the following errors:

- `duplicate id`, finds two or more nodes that share the same id;
- `unknown parent`, finds nodes that have `parent` metadata, but parent not found in the tree;
- `unknown index`, finds nodes with `order_index` metadata where one or more children in the index not found;
- `unknown links`, finds nodes containing links but the links are not found.

## Create project {#fr-create}

------ ---------
__Id__ fr.create
------ ---------

The system shall provide the function to create a new project.  

[Input]{.underline}

Parameter Type     Mult. Description
--------- -------- ----- --------------
directory string   1     project directory

[Output]{.underline}

Parameter Type     Mult. Description
--------- -------- ----- --------------
filename  string    1..N created directory or filename

[Flow]{.underline}

1. Fail "directory exits" if the `directory` already exist
2. Create `directory`
3. Create project structure   
4. Create basic templates
5. Return list of created directories and files

## Assemble artifact {#fr-assemble}

------ -----------
__Id__ fr.assemble
------ -----------

The system shall provide the function to assemble the artifact.

[Input]{.underline}

- NO PARAMETERS

[Output]{.underline}

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | --------------
tree      | [TreeNode](#fr-treenode) |     1 | assembled tree

__Flow__

1. Get list of the project sources
2. Parse sources collecting parsing errors.
3. Fail with the list of parsing errors when any.
4. Assemble the artifact tree based on id, parent, and order_index metadata collecting tree errors.
5. Fail with the list of tree errors if any.
6. Generate auto IDs for nodes without ID.
7. Return artifact tree

## Compile artifact {#fr-compile}

------ ----------
__Id__ fr.compile
------ ----------

The system shall provide the function to create deliverable artifact.

[Input]{.underline}

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | --------------
tree      | [TreeNode](#fr-treenode) |  0..1 | assembled tree
template  | String          |     1 | rendering template
filename  | String          |     1 | output artifact filename

[Output]{.underline}

Parameter Type     Mult. Description
--------- -------- ----- --------------
filename  String       1 output artifact filename

[Flow]{.underline}

1. Assemble the artifact tree by invoking [Assemble artifact](#fr-assemble) unless `tree` parameter provided
2. Load template body from `template`
3. Backup `filename` to `<filename>~` when esists
4. Render `template` for each node of `tree`
5. Save rendered template into `filename`
6. Return `filename`

# Interface Requirements {#ui}

------ --
__Id__ ui
------ --

## Command-line interface {#ui-cli}

------ ------
__Id__ ui.cli
------ ------

The system shall provide the command-line interface. The interface must provide the following commands:

- [Create a new project](#ui-cli-01)
- [Compile artifact](#ui-cli-02)

### Create a new project {#ui-cli-01}

------ ---------
__Id__ ui.cli.01
------ ---------

The system shall provide the `new PROJECT` command. When the user requests the `new PROJECT` command, the system must call [Create project](#fr-create).

### Compile artifact {#ui-cli-02}

------ ---------
__Id__ ui.cli.02
------ ---------

The system shall provide the `compile [-t TEMPALTE] [-o FILENAME]` command. When the user requests the `compile` command, the system must call [Compile artifact](#fr-compile).

## Gem interface {#ui-gem}

------ ------
__Id__ ui.gem
------ ------

The system shall provide Ruby Gem with the following functions

- [Marko.assemble](#ui-gem-01)
- [Marko.compile](#ui-gem-02)

### Marko.assemble {#ui-gem-01}

------ ---------
__Id__ ui.gem.01
------ ---------

### Marko.compile {#ui-gem-02}

------ ---------
__Id__ ui.gem.02
------ ---------

# Assumptions and Dependencies {#as}

## Graphical User Interface {#as-01}

The user will utilize his preferred text editor so no other UI requirement

## Versions and Access management {#as-02}

The user will utilize Git so no other version management or access management requirements

## Deliverables Publishing {#as-03}

The user will publish deliverables by using Pandoc so there are no publishing requirements

