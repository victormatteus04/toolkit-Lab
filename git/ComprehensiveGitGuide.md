# Comprehensive Git Guide

This document provides a detailed guide on using Git, a powerful version control system widely used in software development. It covers a range of topics from basic commands for beginners to advanced features for experienced users, including submodules, hooks, and advanced merge strategies.

## [Part 1: Basic Git Commands](#basic-git-commands)
- [Initializing a Repository](#initializing-a-repository)
- [Staging and Committing Changes](#staging-and-committing)
- [Viewing Commit Logs](#viewing-commit-logs)
- [Branch Management](#branch-management)

## [Part 2: Advanced Git Commands](#advanced-git-commands)
- [Undoing Changes](#undoing-changes)
- [Working with Remote Repositories](#remote-repositories)
- [Examining History and Differences](#examining-history)
- [Stashing and Tagging](#stashing-and-tagging)
- [Understanding .gitignore](#gitignore)
## [Part 3: Extended Git Features](#extended-git-features)
- [Submodules: Managing External Projects](#submodules)
- [Sub-trees: Dependency Management](#sub-trees)
- [Hooks: Automating Git Tasks](#hooks)
- [Rebasing: Linear History](#rebasing)
- [Advanced Merge Strategies](#advanced-merge-strategies)
- [Clone a Specific Subdirectory from a Repository](#clone-a-specific-subdirectory-from-a-repository)

## [Conclusion](#conclusion)



# Part 1: Basic Git Commands

## Version Control
- Introduction to the concept of version control.
- Advantages of using version control in projects.
- Overview of version history management.

## Git Basics
### Creating a Repository
- `git init`: Initialize a new Git repository.
- Creating a `.gitignore` file to specify untracked files.

### Staging and Committing
- `git status`: Check the status of files.
- `git add [file]`: Add files to the staging area.
- `git commit -m "[message]"`: Commit changes with a message.

### Branching and Merging
- `git branch [branch-name]`: Create a new branch.
- `git checkout [branch-name]`: Switch to a different branch.
- `git merge [branch-name]`: Merge a branch into the current branch.

### Examining History
- `git log`: View commit history.

## GitHub Integration
### Setting Up GitHub
- Tutorial on creating a GitHub account and setting up SSH keys.

### Cloning and Remote Repositories
- `git clone [repository-url]`: Clone a remote repository.
- `git remote add origin [repository-url]`: Connect your local repository to a remote repository.

### Push and Pull
- `git pull origin [branch-name]`: Update local repository with changes from the remote repository.
- `git push origin [branch-name]`: Push local changes to the remote repository.

## Workflow
- A walkthrough of the typical Git and GitHub workflow, from initialization to pushing changes to a remote repository.

---



# Advanced Git Commands

## Viewing Changes
- `git diff`: Shows the differences between files in the working directory and the staging area.
- `git diff --staged`: Compares staged changes to the last commit.

## Undoing Changes
- `git checkout -- [file]`: Discards changes in the working directory for a specific file.
- `git reset [file]`: Unstages a file while preserving the changes in the working directory.
- `git reset --hard [commit]`: Resets the current branch to a specific commit and discards all changes since that commit.

## Working with Remote Repositories
- `git fetch [remote]`: Downloads all changes from the remote repository, but doesn't merge them into your own code.
- `git pull`: Combines `git fetch` and `git merge`, updating your current branch with the latest changes from the remote.
- `git push [remote] [branch]`: Sends your commits to the remote repository.

## Branching and Merging
- `git branch`: Lists all branches in your repository.
- `git branch -d [branch-name]`: Deletes a branch safely.
- `git branch -D [branch-name]`: Force deletes a branch, losing changes on that branch.
- `git merge [branch]`: Merges the specified branch into the current branch.

## Stashing
- `git stash`: Temporarily stores all modified tracked files.
- `git stash pop`: Applies stashed changes and removes them from the stash.
- `git stash apply`: Applies stashed changes without removing them from the stash.

## Tagging
- `git tag [tag-name]`: Marks a specific point in the repository’s history as important, typically used for releases.

## Git Log
- `git log --oneline`: A condensed view of the commit history.
- `git log --graph`: Displays the branch and merge history in an ASCII graph.

## .gitignore
- `.gitignore`: A text file where you can specify files and directories to be ignored by Git.

# Extended Git Features

## Submodules
- **Purpose:** Allow a Git repository to contain, as a subdirectory, a checkout of an external project.
- **Usage:** 
  - `git submodule add [URL] [directory]`: Adds a new submodule.
  - `git submodule init`: Initializes a submodule.
  - `git submodule update`: Updates the submodule to the commit specified by the superproject.
- **Benefits:** Useful for including libraries or other external projects within your repository.

## Sub-trees
- **Purpose:** Alternative to submodules, used to manage dependencies.
- **Usage:** 
  - `git subtree add --prefix [directory] [repository] [branch]`: Adds a subtree.
  - `git subtree pull --prefix [directory] [repository] [branch]`: Updates the subtree with the latest changes.
- **Benefits:** Easier to use and more flexible than submodules, especially for contributors who don't need to know about the existence of the subtree.

## Hooks
- **Purpose:** Scripts that run automatically on specific important actions in the Git workflow, like commit, push, and receive.
- **Usage:** 
  - Located in the `.git/hooks` directory.
  - Rename a sample hook file (e.g., `pre-commit.sample` to `pre-commit`) and customize it.
- **Benefits:** Allows for automation of certain tasks like code testing, style check, or build processes.

## Rebasing
- **Purpose:** Reapply commits on top of another base tip.
- **Usage:** 
  - `git rebase [base]`: Reapplies commits on top of the specified base.
  - `git rebase -i [base]`: Interactive rebasing allows you to modify commits as they are moved to the new base.
- **Benefits:** Cleaner, linear history. Useful for cleaning up commit history before merging a feature branch into the main branch.

## Advanced Merge Strategies
- **Purpose:** Resolve complex merge conflicts and combine code from different branches.
- **Usage:**
  - `git merge --no-ff`: Creates a merge commit even if a fast-forward merge is possible.
  - `git merge --squash`: Combines all changes into a single commit.
- **Benefits:** Allows for more control over the merge process and commit history.

## Clone a Specific Subdirectory from a Repository
- **Purpose:** Clone only a specific subdirectory from a repository.
- **Usage:** 
  - `git clone --depth 1 --branch INSERT_BRANCH_NAME --no-checkout INSERT_REPO_REMOTE_URL`: Clone the repository without checking out the files.
  - `cd INSERT_ROOT_FOLDER/`: Change directory to the root folder of the repository.
  - `git sparse-checkout set INSERT_SUBDIRECTORY_RELATIVE-PAT`: Set the subdirectory to be checked out.
  - `git checkout`: Check out the subdirectory.
- **Benefits:** Useful for large repositories where you only need a specific subdirectory.

# Conclusion

The guide is structured to provide a step-by-step approach to learning and mastering Git. It starts with fundamental concepts and commands, progresses to more advanced techniques, and finally delves into the extended features of Git that are crucial for handling complex projects and workflows.

---

