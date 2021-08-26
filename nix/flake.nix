{
  description = "Main configuration on top of nix flakes";
  inputs = {
    home-manager = {
      url = "github:rycee/home-manager/release-21.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
  };

  outputs = inputs@{ self, home-manager, nur, nixpkgs, ... }:
  let
    inherit (builtins) listToAttrs attrValues attrNames readDir;
    inherit (nixpkgs) lib;
    inherit (lib) removeSuffix;
    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      overlays = attrValues self.overlays;
    };

  in
  {
    overlays =
      let
        overlayFiles = listToAttrs (map
        (name: {
          name = removeSuffix ".nix" name;
          value = import (./overlays + "/${name}");
        })
        (attrNames (readDir ./overlays)));
      in
      overlayFiles // {
        nur = final: prev: {
          nur = import inputs.nur { nurpkgs = final.unstable; pkgs = final.unstable; };
        };
        emacs-overlay = inputs.emacs-overlay.overlay;
        unstable = final: prev: {
          unstable = import inputs.unstable {
            system = final.system;
            config = {
              allowUnfree = true;
            };
          };
        };
        master = final: prev: {
          master = import inputs.master {
            system = final.system;
            config = {
              allowUnfree = true;
            };
          };
        };
      };
      nixosConfigurations.lap = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.horhik = {
              imports = [
                ./modules/picom.nix
                ./modules/tmux.nix
                ./modules/bspwm
              ];
            };
          })

          { nixpkgs.overlays = overlays; }
        ];
        inherit pkgs;
      };
  };
}
