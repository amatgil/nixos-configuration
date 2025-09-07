{
  description = "My (casenc) system's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Keep HA and the system's nixpkgs version the same
    };
    #stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561"; # Latest one doesn't work lmao

    #BAD gnome stylix.url = "github:danth/stylix/b001c0b513e323cc4265e1ca96b7463bb93285b7"; # Latest one doesn't work AGAIN :sob:
    #BAD cursor stylix.url = "github:danth/stylix/8762da957b8b04b8b73248144f1c0ff7a88924b5"; # Latest one doesn't work AGAIN :sob:
    stylix.url = "github:danth/stylix/8762da957b8b04b8b73248144f1c0ff7a88924b5"; # Latest one doesn't work AGAIN :sob:

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
