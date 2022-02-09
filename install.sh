#!/bin/bash
for d in */ ; do
    stow --restow "$d"
done
