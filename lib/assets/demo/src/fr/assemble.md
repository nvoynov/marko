# Assemble artifact
{{id: .assemble, parent: fr}}

The system shall provide the function to assemble the artifact.

[Input]{.underline}

- NO PARAMETERS

[Output]{.underline}

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | --------------
tree      | [[fr.treenode]] |     1 | assembled tree

__Flow__

1. Get list of the project sources
2. Parse sources collecting parsing errors.
3. Fail with the list of parsing errors when any.
4. Assemble the artifact tree based on id, parent, and order_index metadata collecting tree errors.
5. Fail with the list of tree errors if any.
6. Generate auto IDs for nodes without ID.
7. Return artifact tree
