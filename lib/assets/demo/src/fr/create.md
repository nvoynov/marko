# Create project
{{id: .create, parent: fr}}

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
