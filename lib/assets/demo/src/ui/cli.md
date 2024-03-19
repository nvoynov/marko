# Command-line interface
{{id: .cli, parent: ui}}

The system shall provide the command-line interface. The interface must provide the following commands:

@@list

## Create a new project

The system shall provide the `new PROJECT` command. When the user requests the `new PROJECT` command, the system must call [[fr.create]].

## Compile artifact

The system shall provide the `compile [-t TEMPALTE] [-o FILENAME]` command. When the user requests the `compile` command, the system must call [[fr.compile]].
