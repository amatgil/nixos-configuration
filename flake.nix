{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.dreanix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
