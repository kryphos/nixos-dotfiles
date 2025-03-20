inputs@{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/profiles/headless.nix
  ];

  wsl = {
    enable = false;
    defaultUser = "luca";
  };

  boot.loader.grub = {
    enable = false;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
