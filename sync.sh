#!/usr/bin/env bash

set -e

pushd ~/code/nixos-dotfiles/

git pull
git submodule update --init --recursive

echo "NixOS Syncing..."

sudo nixos-rebuild switch --impure --upgrade --flake .?submodules=1#$(hostname) \
    || (
        echo "NixOS Sync Failed!" \
        && notify-send -e "NixOS Sync Failed!" --icon=dialog-error \
        && exit 1 \
    )

echo "NixOS Sync OK!"
notify-send -e "NixOS Sync OK!" --icon=software-update-available

popd
