{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
    #stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561"; # Latest one doesn't work lmao
    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs ={ self, nixpkgs, home-manager, stylix, ... }@inputs: {
    nixosConfigurations = {
      dreanix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          stylix.nixosModules.stylix
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
          stylix.nixosModules.stylix
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
