# Template
{{id: .tt, parent: fr}}

The system shall provide templates for building deliverables for the artifact. Each project can have 0..n templates. Each template must be well-formed ERB.

Example:

```
<%= @node.header %>
<%= @node.meta   %>
<%= @node.body   %>
```

@@todo
