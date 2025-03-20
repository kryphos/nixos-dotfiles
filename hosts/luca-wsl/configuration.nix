inputs@{ ... }:
{
  imports = [
    <nixos-wsl/modules>
    ../../modules/system/profiles/wsl.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "luca";

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
