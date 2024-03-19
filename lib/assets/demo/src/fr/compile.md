# Compile artifact
{{id: .compile, parent: fr}}

The system shall provide the function to create deliverable artifact.

[Input]{.underline}

Parameter | Type            | Mult. | Description
--------- | --------------- | ----- | --------------
tree      | [[fr.treenode]] |  0..1 | assembled tree
template  | String          |     1 | rendering template
filename  | String          |     1 | output artifact filename

[Output]{.underline}

Parameter Type     Mult. Description
--------- -------- ----- --------------
filename  String       1 output artifact filename

[Flow]{.underline}

1. Assemble the artifact tree by invoking [[fr.assemble]] unless `tree` parameter provided
2. Load template body from `template`
3. Backup `filename` to `<filename>~` when esists
4. Render `template` for each node of `tree`
5. Save rendered template into `filename`
6. Return `filename`
