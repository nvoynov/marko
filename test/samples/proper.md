# Title

The sample of well-formed markup source with no errors inside that might fail parsing and assembling the tree

The rest of the body can be skipped, that might serve as "for authors only"

The following macro will be replaced for the table of contents:

@@tree

## a
{{id: a, order_index: .a1 .a2 .a3}}

This topic consists of the following items:

@@list

## b
{{id: b}}

@@skip

This line till the end of the node will be skipped

## c

This topic shows different scenarios of \@\@todo macro

@@todo this is just simple todo that should be removed till the "\n"

The next line will be bare \@\@todo that might have some meaning for authors

@@todo

And finally the following \@\@todo should be smart enough to not ruin the list structure

- one
- two @@todo ending "\n" should be preserved
- three

# a 1
{{id: .a1, parent: a}}

see [[b]]

# a 3
{{id: .a3, parent: a}}

# a 2
{{id: .a2, parent: a}}
