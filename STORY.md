---
title: Marko Story
date: 2023-01-26
...

[Marko](https://github.com/nvoynov/marko) is the result of my ten-year journey with Ruby playing the Business Analyst role.

## Childhood, 2012

Somewhere in between 2011 and 2014 I was playing Software Engineer role in some BigKnownCo where my first and foremost working tool was Microsoft Word 2007. Requirements specifications and Architecture design documents Artifacts that I was mainly working on often consisted of one and more hundreds of pages and it was such a pain to deal with in MS Word which was the corporate standard.

In simple words it just gone crazy on large documents, the program consumed all my RAM, document navigation was slow, the program simply stopped responding, which entailed restarting the process with a loss of changes; or even worse, the loss of style formatting that is invisible to the eye when you simply cannot see it that the formatting was lost somewhere on the 225th page.

> So problem was clear "__The problem of__ the lack of simple reliable tools and approaches for writing software artifacts __affects__ technical writers who develop and manage the artifacts __the impact of which is__ they tend to choose.."

And I come up with the idea to create something light, simple and reliable to eliminate the MS Word from my work experience once and for all. This time I was curious about using YAML for storing requirements just inside file system. And I regularly done some estimations and prioritization for requirements, so I decided that FPA, PERT, and Risk-Value prioritization will be valuable features here.

It was my first serious diving into Ruby for few weeks. I succeeded in reading / writing YAML and even provided estimations algorithms. I fall in love with Ruby. But from user perspective (I was the user) it was complete failure. Writing YAML manually was just unforgivable but that time I was obsessed with the format.

> YAML was chosen just because this days I dramatically reduced time for load configuration of my target service provisioning system, that stored its configuration tree in RDBMS that causes ~5 000 000 selects for reading and about the same number insert/update for writing. It just reduced to 20 000 instead of 5 000 000.

## Adolescence, 2014 - 2015

It took two years to return to the subject, I left that job in 2014 and got haft year off. This time I discovered Markdown and static site generators, and I decided on Markdown as my primary markup format, where each source is just a plain markdown file with some metadata excerpt.

Things were going well and in a few months, I got something quite usable. Estimations algorithms were thrown out; markup sources were assembled in one artifact that was translated into HTML by Kramdown. I named it "Creq" for "console requirements" and since then I assembled all software artifacts in my own tool.

## Youth, since 2015

Using my tool daily on a regular basis I discovered Pandoc and then can translate my artifact into any supported format; provided more advanced artifact templates, and provided a few templates for different purposes (draft, customer deliverable, etc.), added macros for tree node body.

This time I named my tool Clerq because it just was my regular tool - I started my day from `$ git checkout -b new_feature` and finished with merging the branch, assembling new requirements increment, and pushing into git for my development team.

In 2018 I have read The Clean Architecture I took my first clumsy attempts to apply it for Clerq.

## Marko, 2022

The last time I used Clerq for two months in July 2022. I noticed that time that I use only "create a new project" and "build the artifact" commands. And I realized that there is nothing about requirements - just about artifact assembling.

So I took two weeks and finished 2022 with a git commit on Dec 31, 2022 :)

The Marko purpose is assembling markup artifact from separated markup sources. Its interfaces are simple and clear. It could be naturally extended through Rakefile for any specific purpose related to visiting artifacts tree nodes.

This is the first time I feel for a product that there are nothing I want to take or change. Just "Right Product, Done Right, Managed Messy"
