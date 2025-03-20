{
  description = "NixOS system configuration";

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      disko,
      home-manager,
      nix-ld,
      nixos-hardware,
      nixpkgs,
      nur,
      spicetify-nix,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      commonModules = [
        disko.nixosModules.disko
        nix-ld.nixosModules.nix-ld
        home-manager.nixosModules.default
        spicetify-nix.nixosModules.default
      ];

      hosts = {
        "luca-notebook" = {
          modules = [ nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen ];
        };
        "luca-pc" = {
          modules = [ ];
        };
        "luca-wsl" = {
          modules = [ ];
        };
      };

      mkConfig =
        name:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              system
              inputs
              spicetify-nix
              ;
          };
          modules =
            commonModules
            ++ hosts.${name}.modules
            ++ [
              { networking.hostName = name; }
              ./hosts/${name}/configuration.nix
            ];
        };

      configs = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = mkConfig name;
        }) (builtins.attrNames hosts)
      );
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      nixosConfigurations = configs;
    };
}
