#!/usr/bin/env bash

name=$1
if [ -z "$name" ]; then
  echo "Usage: $0 <hostname>"
  exit 1
fi

git config --global user.name "apok"
git config --global user.email "<>"
git config --global credential.helper store

git clone https://github.com/kryphos/nixos-dotfiles.git ~/code/nixos-dotfiles --recursive

pushd ~/code/nixos-dotfiles
sudo nixos-rebuild switch --impure --flake .?submodules=1#$name
popd

rustup default stable
mkdir ~/documents ~/downloads ~/music ~/pictures ~/videos
tms config -p ~/code

nvim +:TransparentEnable
