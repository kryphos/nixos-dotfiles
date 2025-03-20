inputs@{ ... }:
{
  imports = [
    <nixos-wsl/modules>
    ../../modules/system/profiles/wsl.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
