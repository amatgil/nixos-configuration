{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
  };

  outputs ={ self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      dreanix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixosModules/shared-config.nix
          ./nixosModules/dreanix/hardware-config.nix
          ./nixosModules/dreanix/dreanix-config.nix
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
          ./nixosModules/shared-config.nix
          ./nixosModules/nixpad/hardware-config.nix
          ./nixosModules/nixpad/nixpad-config.nix
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
