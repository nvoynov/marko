# Clerq Gem interface
{{id: .gem}}

The system shall provide Ruby Gem with the following interface

```ruby
# Assemble the artifact tree
# @return [Node] root node
def assembly
end

# @param template
def build(template, filename)
end
```
