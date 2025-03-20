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

  # this doesnt actually do anything but has to be here
  boot.loader.grub = {
    device = "/dev/sdc";
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
