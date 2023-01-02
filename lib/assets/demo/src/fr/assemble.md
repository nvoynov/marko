# Assemble artifact
{{id: .assemble, parent: fr}}

The system shall provide the function to assemble artifact.

__Input__

* NO

__Output__

Parameter Type     0..* Description
--------- -------- ---- --------------
tree      TreeNode 1    assembled tree

__Flow__

@@todo provide id for required functions and change steps with appropriate links

1. get list of project sources
2. parse sources buffering nodes and errors
3. fail "parsing errors" if errors.any?
4. assemble artifact from buffer of nodes
5. generate and inject auto ids
6. validate artifact buffering errors
7. fail "tree errors" if errors.any?
8. return artifact
