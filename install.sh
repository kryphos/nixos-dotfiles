#!/usr/bin/env bash

set -e

echo "WIP" && exit 1

disk=$1
if [ -z "$disk" ]; then
  echo "Usage: $0 <disk>"
  exit 1
fi

sudo cp install.nix /tmp/config/etc/nixos/flake.nix
sudo nixos-generate-config --root /tmp/config --no-filesystems
sudo nix \
    --experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest#disko-install'\
    -- \
    --flake '/tmp/config/etc/nixos#default' \
    --disk main $disk \
    --write-efi-boot-entries
