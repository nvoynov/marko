# Intro
{{id: intro}}

# Users
{{id: usr}}

The users of the system are different people who play for authoring various sorts of technical documentation. It might be a technical writer, business/systems analyst, developer, etc.

# User Requirements
{{id: ur, order_index: uc}}

## Use Cases
{{id: uc, order_index: .create.project .general.flow}}

# Functional Requirements
{{id: fr, order_index: .treenode .markup .storage .assemble .compile}}

# Interface Requirements
{{id: ui, order_index: .cli .gem}}

# Assumptions and Dependencies
{{id: as}}

##

The system requires a user interface for managing markup sources. It is assumed that users utilize any text editor of their choice.

##

The system requires tools for collaboration on artifacts by several authors simultaneously. Because of the plain text nature of the markup sources, It is assumed using Git for managing the artifact sources repository.

##

The system requires the compilation of artifacts into deliverables in form of well-supported formats like pdf, doc, etc. It is assumed using Pandoc for creating deliverables.
