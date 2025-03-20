inputs@{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/profiles/laptop.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
