{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
    stylix.url = "github:danth/stylix";
  };

  outputs ={ self, nixpkgs, home-manager, stylix, ... }@inputs: {
    nixosConfigurations = {
      dreanix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          stylix.nixosModules.stylix
          ./nixosModules/shared-config.nix
          ./nixosModules/specific-dreanix.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.casenc = import ./nixosModules/home.nix;
          }
        ];
      };
      nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          stylix.nixosModules.stylix
          ./nixosModules/shared-config.nix
          ./nixosModules/specific-nixpad.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.casenc = import ./nixosModules/home.nix;
          }
        ];
      };
    };
  };
}
