inputs@{ pkgs, ... }:
{
  imports = [ ../../modules/system/profiles/headless.nix ];
  wsl.enable = true;

  users.users = {
    "nixos" = {
      isNormalUser = true;
      home = "/home/nixos";
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
      "nixos" = import ./home.nix;
    };
  };
}
