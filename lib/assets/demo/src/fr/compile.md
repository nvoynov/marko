# Compile artifact
{{id: .compile, parent: fr}}

The system shall provide the function to create deliverable artifact.

__Input__

Parameter Type     0..* Description
--------- -------- ---- --------------
tree      TreeNode 1    assembled tree
template  String   1    ERB template
filename  String   1    filename

__Output__

The output of the function must be well-formed deliverable with `filename` built on `template` parameter.

__Flow__

@@todo provide id for required functions and change steps with appropriate links

1. `tree` = [[fr.assemble]] unless `tree`
2. load template body from `template`
3. backup `filename` to `<filename>~`
4. render `template` for each node of `tree` into `filename`
