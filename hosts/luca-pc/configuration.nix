inputs@{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/profiles/desktop.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
  };

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

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
