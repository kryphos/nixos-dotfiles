{ pkgs, ... }:
{
  users.users = {
    "luca" = {
      isNormalUser = true;
      home = "/home/luca";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };
}
