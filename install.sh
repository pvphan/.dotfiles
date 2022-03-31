#!/bin/bash
for d in */ ; do
    stow --restow "$d"
done

mkdir -p ~/.config/mpv/
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ln -sf $SCRIPT_DIR/mpv/input.conf ~/.config/mpv/input.conf
