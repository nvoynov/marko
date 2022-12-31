# General Clerq flow
{{id: uc.general.flow, parent: uc}}

__Prerequisites__

1. The user has created a Clerq project (see [[uc.create.project]])

__Main Flow__

1. The user creates and makes changes to the sources of the project. [outside the system]
2. The user requests the system to `build` the artifact. @@todo suitable passing `template`, `filename`, and `id`.
3. The system assembles the artifact from source files.
4. The system checks the artifact and reports the errors to the user if any.
5. The system returns the assembled artifact.

__Extension__

@@todo 2a. When user passed `template` ...
