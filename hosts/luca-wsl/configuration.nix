inputs@{ ... }:
{
  imports = [ ../../modules/system/profiles/headless.nix ];
  wsl.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luca" = import ./home.nix;
    };
  };
}
