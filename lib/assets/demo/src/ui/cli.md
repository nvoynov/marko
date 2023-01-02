# Command-line interface
{{id: .cli, parent: ui}}

The system shall provide a command-line interface. The interface must provide the following commands:

@@list

## Create a new project

The system shall provide the `new PROJECT` command. When the user requests the `new PROJECT` command, the system

- ensures that `PROJECT` folder does not exist or fails
- creates `PROJECT` folder and copies required files for new project
- reports the user about success  

## Compile artifact

The system shall provide the `compile [-t TEMPALTE] [-o FILENAME]` command. When the user requests the `compile` command, the system

- ensures that current directory is `Marko Project` directory, or fails
- load `template`,
  - load from the `TEMPLATE` parameter when provided
  - or load default template when not
- creates `tree` by using [[fr.assemble]]
- compiles the tree by [[fr.compile]].(`tree`, `template`, `filename`)
- reports the user about success
