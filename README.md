# NixOS System Configuration

## Install

<!--Bootstrap the system from an install medium using:-->
<!--```shell-->
<!--git clone https://github.com/kryphos/nixos-dotfiles.git-->
<!--cd nixos-dotfiles-->
<!--./install.sh /dev/<drive>-->
<!--```-->

Use the graphical installer to install NixOS. On the new system then run inside `nix-shell -p wget git`:

```shell
wget https://raw.githubusercontent.com/kryphos/nixos-dotfiles/refs/heads/master/setup.sh
chmod +x setup.sh
./setup.sh <hostname>
```

## Config Changes

- `./rebuild.sh`: Use to update the system after _local_ changes.
- `./sync.sh`: Use to update the system after _remote_ changes.
