# Compile artifact
{{id: uc.compile, parent: uc}}

The scenario is used when the user wants to compile the artifact from the artifact sources

__Prerequisites__

1. The user inside Marko project (see [[uc.create]])

__Main Flow__

1. The user requests the system to compile the project sources into the artifact passing compilation template.
2. The system read the artifact sources and assembles it into the artifact tree; no errors detected.
3. The system compiles the artifact tree into single artifact using provided template.
4. The system reports compiled artifact filename to the user.
5. The scenario is finished.  

__Extensions__

[2a]{.underline} The system detected markup errors inside sources: The system reports the errors found to the user; the scenario is finished.

[2b]{.underline} The system detected tree structure errors during the assembling stage: The system reports the errors found to the user; the scenario is finished.
