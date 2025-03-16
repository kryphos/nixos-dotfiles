{
  description = "NixOS system installation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs; };
        modules = [
          ./configuration.nix
          disko.nixosModules.disko
          {
            environment.defaultPackages = [ ];
            environment.systemPackages = with pkgs; [
              git
              vim
            ];
          }
          {
            disko.devices = {
              disk = {
                main = {
                  type = "disk";
                  device = "/dev/sdX"; # Replace with actual disk (or override at runtime)
                  content = {
                    type = "gpt";
                    partitions = {
                      ESP = {
                        priority = 1;
                        name = "ESP";
                        start = "1M";
                        end = "128M";
                        type = "EF00";
                        content = {
                          type = "filesystem";
                          format = "vfat";
                          mountpoint = "/boot";
                          mountOptions = [ "umask=0077" ];
                        };
                      };
                      root = {
                        size = "100%";
                        content = {
                          type = "btrfs";
                          extraArgs = [ "-f" ];
                          mountpoint = "/";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                      };
                    };
                  };
                };
              };
            };
          }
        ];
      };
    };
}
