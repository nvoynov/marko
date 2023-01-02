# Faulty identifiers

This content serves for checking errors with identifiers and lost links. That file being included into sources will cause Parsing Failure.

The leading four nodes have the same identifiers "adup" and "bdup" respectively

## a1
{{id: adup}}

## a2
{{id: adup}}

## b1
{{id: bdup}}

## b2
{{id: bdup}}

# a
{{order_index: a1 a2}}

This node will cause tree error for index [a1, a2] that the node assumes to have in items

# b
{{parent: lost}}

This node should should report about lost parent

# c
{{parent: lost}}

And this should report about lost parent and lost link [[lost]]

## d

This also will report about lost link [[lost]] and another lost link [[lost_more]]
