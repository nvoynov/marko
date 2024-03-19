# Create a new project
{{id: uc.create, parent: uc}}

The scenario is used when the user wants to create a new Marko artifact project

__Main Flow__

1. The user requests the system to create a new project passing the directory name for the project.
2. The system checks the directory does not exist; directory des not exist.
3. The system creates the directory and furnish it with basic Marko structure.
4. The system reports to the user about created directories and files.
5. The scenario is finished

__Extensions__

[2a]{.underline} The directory exists: The system reports to the user that the directory exits. The scenario if finished.
