# Source Markup
{{id: .markup, parent: fr}}

The main and only entity in the system is [[fr.node]]. The system shall provide the following abilities for the entity:

@@list

## Node Markup
{{id: .node}}

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

## Get Sources

The system shall provide function to getting all sources files from project repository.

@@todo project repository

## Parse Source

The system shall provide the function to parse source file.

During the parsing process the system must record source information within the node parsed, such as origin file name and the number of line inside the origin where the node begins. This information must be stored inside metadata as [[fr.node.orig]].

__Input__

Parameter Type   0..* Description
--------- ------ ---- -----------
filename  String 1    filename

__Output__

Parameter Type   0..* Description
--------- ------ ---- -----------
node      Node   0..n node parsed

## Assemble Tree

The system shall provide the function to assemble the artifact tree. The artifact tree is assembled based on [[fr.node.tree]].

@@todo The assemblage algorithm, errors handler

__Input__

Parameter Type   0..* Description
--------- ------ ---- -----------
node      Node   0..n node array

__Output__

Parameter Type   0..* Description
--------- ------ ---- -----------
node      Node   1    root tree

## Inject Id

The system shall provide each node with unique node Id.

Some nodes can already have ids from source file, especially those that referenced as parent or child and placed in separate files. For those nodes that still have empty id, the system must generate auto id 0..99.

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

Parameter Type   0..* Description
--------- ------ ---- -----------
root      Node   1    root node

## Checking Tree

The system shall provide the function to check assembled tree for errors related to assembling tree based on [[fr.node.tree]]. The system must check the following errors:

- `duplicate id`, finds two or more nodes that share the same id;
- `unknown parent`, finds nodes that have `parent` metadata, but parent not found in the tree;
- `unknown index`, finds nodes with `order_index` metadata where one or more children in the index not found;
- `unknown links`, finds nodes containing links but the links are not found.
