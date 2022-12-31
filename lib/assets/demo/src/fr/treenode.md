# TreeNode
{{id: .treenode, parent: fr}}

The system shall provide `Node` entity with the following properties that provide the following attributes:

Property  Type   *..n Default Description
--------- ------ ---- ------- -----------
id        String 1    ""      Node identifier
parent    Node   1    null    Parent node reference
title     String 1    ""      Node title
meta      Hash   1    {}      Node metadata
body      String 1    ""      Node body
items     Node   0..n []      Child node reference

## Tree Metadata
{{id: .tree}}

To assemble the project artifact from nodes placed among several source files, the system shall provide the following optional tree metadata attributes:

Attribute   Type   0..n Description
----------- ------ ---- --------------
id          String 0..1 Unique node id
parent      String 0..1 Parent id
order_index String 0..1 Children ids delimited by space

## Source Metadata
{{id: .orig}}

During source file parsing, the system must store the following node origin information:

Attribute   Type   0..n Description
----------- ------ ---- --------------
origin      String 1    Source filename
lineno      String 1    Number of line
