#!/usr/bin/env bash

set -e

pushd ~/code/nixos-dotfiles/

git submodule update --init --recursive

nix fmt

git -P diff -U0

echo "NixOS Rebuilding..."
git add .

sudo nixos-rebuild switch --impure --upgrade --flake .?submodules=1#$(hostname) --show-trace \
    || (
        echo "NixOS Rebuild Failed!" \
        && notify-send -e "NixOS Rebuild Failed!" --icon=dialog-error \
        && exit 1 \
    )

current=$(nixos-rebuild list-generations | grep current)
git commit -m "$current"
git push

echo "NixOS Rebuilt OK!"
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

popd
