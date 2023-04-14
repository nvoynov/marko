% Marko Demo Project

Welcome to your new [Marko](https://github.com/nvoynov/marko) project!

# Structure

This project has the following structure:

- [bin/](bin/) - output folder
- [bin/assets/](bin/assets/) - assets folder
- [src/](src/) - markup sources
- [tt/](tt/) - templates
- [marko.yml](marko.yml) - project configuration
- [Rakefile](Rakefile) - Rakefile
- [README.md](README.md)

# Interface

Run `marko` command in your console to see basic command-line interface.

Extend it yourself through Rakefile

# Git Repository

[Git How To](https://githowto.com/)

Incorporates changes from a remote repository:

    git pull

Create a new branch to start any activity with the repository:

    git branch <branch_name>

Make changes and commit your work:

    git add .
    git commit -m "branch_name - commit description"

When your changes finished, incorporate changes from the remote repository and merge the `master` branch to your `branch_name`:

    git checkout master
    git pull
    git checkout <branch_name>
    git merge master

Resolve all conflicts and commit changes:

    git add .
    git commit -m "branch_name conflicts resolved"

Merge your changes to the `master` branch:

    git checkout master
    git merge <branch_name>

Push your changes to the remote repository:

    git push

Create a merge request if you are not allowed to push to the `master` branch.
