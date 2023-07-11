#!/usr/bin/env bash

#- Requirement: cargo install cargo-get

version=$(cargo get version)
rev=$(git rev-list --count HEAD)
tag="v${version}-${rev}"

if [ -z "$(git status --porcelain)" ]; then
    # Working directory clean
    git tag ${tag}
    echo "Tag ${tag} was created, now run: git push --tags"
else
    # Uncommitted changes
    echo "ERROR: working directory is dirty"
    exit 1
fi
