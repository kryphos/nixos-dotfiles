inputs@{ ... }:
{
  imports = [
    <nixos-wsl/modules>
    ../../modules/system/profiles/headless.nix
  ];

  wsl = {
    enable = false;
    defaultUser = "luca";
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
