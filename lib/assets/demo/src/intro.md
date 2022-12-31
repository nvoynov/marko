# Introduction
{{id: intro, parent: 0}}

## Purpose

The main purpose of this document is to provide a comprehensive Clerq demo project. The other technical purpose is to get Clerq Sandbox for working on new features.

## Scope

The purpose of the system is to provide a simple efficient "docs-as-code" tool for technical writers for managing technical artifacts for software development. The system that provides the following items:

- the artifact source markup format
- the artifact assembling algorithm
- the artifact template for publication

This software will be a Ruby Gem, that provides services for assembling the artifact from set of separate source files. The gem will provide command-line interface for building the artifact.

## Definitions

CLI

:   Command-line interface

ERB

:   Ruby Templating system


## References

1. [Markdown Guide](https://www.markdownguide.org/)
2. [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
3. [Git User's Manual](https://git-scm.com/docs/user-manual.html)

## Overview

The remaining sections of this document provide user requirements and functional requirements of the system.

The next chapter [[us]] introduces the system from User Stories' point of view and establishes the context for the functional requirements. The chapter is organized by user roles.

The following chapter [[fr]] describes detailed requirements for functions and user interfaces that are based on user stories from the previous chapter. The chapter is structured around system components and is written primarily for developers and quality assurance specialists.
