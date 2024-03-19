# TreeNode
{{id: .treenode, parent: fr}}

The system shall provide `Node` entity with the following properties that provide the following attributes:

Property  Type     Mult. Default Description
--------- -------- ----- ------- -----------
id        String       1    ""      Node identifier
parent    Node         1    null    Parent node
title     String       1    ""      Node title
meta      Hash         1    {}      Node metadata
body      String       1    ""      Node body
items     TreeNode  0..N    []      Child nodes

## Tree Metadata
{{id: .tree}}

To assemble the project artifact from nodes placed among several source files, the system shall provide the following optional tree metadata attributes:

Attribute   Type   Mult. Description
----------- ------ ----- --------------
id          String  0..1 Unique node id
parent      String  0..1 Parent id
order_index String  0..N Children IDs

## Source Metadata
{{id: .orig}}

During source file parsing, the system must store the following node origin information:

Attribute   Type   Mult. Description
----------- ------ ----- --------------
origin      String     1 file name
lineno      String     1 file line
