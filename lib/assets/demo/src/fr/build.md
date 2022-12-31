# Create deliverable artifact
{{id: .build, parent: fr}}

The system shall provide the function to create deliverable artifact.

__Input__

Parameter Type   0..* Description
--------- ------ ---- -----------
template  String 1    template
filename  String 1    filename

__Output__

The output of the function must be well-formed deliverable with `filename` built on `template` parameter.

__Flow__

@@todo provide id for required functions and change steps with appropriate links

1. Get list of project sources
2. Parse each source and put the result into a buffer
3. Assemble the artifact tree from the buffer
4. Generate and inject auto ids into the tree
5. Load ERB template
6. Create the output filename, make a backup copy `<filename>~` if the file already exists
7. Render the template for each node in the tree.
