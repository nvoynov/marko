---
title: Marko Story
date: 2023-01-30
keywords:
- marko-markup-compiler
- requirements-management
...

The [Marko Story](story.html) mentions about "requirements management" so I decided to tell what kind of automation I designed for myself being on the Business/Systems Analyst position.

My simplified "analyst routine" could resemble something like

- design requirements
- provide deliverables
- ensure quality
- facilitate prioritization and effort estimation processes

## Designing requirements

Starting a new requirements project I create a new Marko ~~Clerq~~ project and place it under Git repository. That way my team and I will have history of changes and other authors can work on the requirements with me but in different branches.

Then during the project duration I just create and modify markup sources inside `src` directory of my Marko project. When I need include images or other assets I just place it under bin/assets and provide link `![My Image](#my-image.png)`

## Providing deliverables

At the beginning when we worked as s Startup my cycle was easy enough. Requirements deliverable format was HTML and I just pushed a new increment into the `master` branch; git hook on server build HTML and placed it on particular URL depending on project; the URL was accessible inside internal network (was up to our sys admin.)

Maybe it still the simplest and effective approach. But having customers you need to follow some schema agreed with the customer and it usually follows you to Confluence, MS Word, or Google Documents. Having Pandoc it's actually easy at least for last two, but ...

One of the consequences of providing deliverables is feedback that you as analyst is usually starving to get as early as possible. And Confluence is perfect tool to share deliverables, but not so good to design it inside, at least for me. So I always tried to postpone such publishing. And there Marko ~~swear word~~ unfortunately.

A few times I thought to design sort of bridge between Clerq and Confluence, but always had no enough time for such move.

## Ensuring quality

This is rather wide subject that depend on many things, but having `TreeNode#meta` hash and `Marko.assemble` you can easily develop your own flow.

I'm sure that one should think about requirements attributes subset suited for one's project and provide it durign requirements design by placing into `TreeNode#meta` (`rationale`, `originator`, `fit_criterion`, `customer-satisfaction`, `customer-dissatisfaction`, `conflict`, `complexity`, `effort`, `risk`, `priority`, `derived`, `depends`, `necessity`, `reduce-effort`, `satisfy`, `validate`, etc.)

For example when you have a few stakeholders it is a good idea to identity at least  requirement originator.

```markdown
# Some requirement
{{
id: .some.id
parent: fr
originator: Marko
}}

Lorem ipsum dolor sit amet, consectetur
adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi
ut aliquip ex ea commodo consequat.
```

> You even could provide your own metadata excerpt with YAML and handle it by your own Rake task.

So, having established attributes you can provide some validation and verification rules, like follows, but it will require basic knowledge of Ruby.

- each 'User Requirement' must have 'originator';
- each 'Functional' must refer to 'derived';
- each 'Test case' must refer to 'validates';
- etc.

## Facilitating thing

Requirements is a perfect asset to derive some usual secondary artifacts like prioritization and estimations sheets. You can design your own template there, or just write some code to create CSV, or sort of.
