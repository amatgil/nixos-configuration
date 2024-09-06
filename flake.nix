{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
    stylix.url = "github:danth/stylix";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs ={ self, nixpkgs, home-manager, nixos-generators, stylix, ... }@inputs: {
    nixosConfigurations = {
      dreanix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          stylix.nixosModules.stylix
          ./nixosModules/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.casenc = import ./nixosModules/home.nix;
          }
        ];
      };
    };
    iso = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "iso";
      modules = [
        ./nixosModules/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.casenc = import ./nixosModules/home.nix;
        }
      ];
    };
  };
}
