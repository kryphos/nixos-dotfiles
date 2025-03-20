inputs@{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/profiles/desktop.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
