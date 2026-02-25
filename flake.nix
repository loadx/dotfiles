{
  description = "Decentralized Host Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      darwin,
      home-manager,
      ...
    }:
    let
      # Initialize our shared helpers
      helpers = import ./lib/helpers.nix { inherit (nixpkgs) lib; };
   in
    {
      # --- MacOS Hosts ---
      darwinConfigurations.amber = import ./hosts/amber/default.nix { 
        inherit inputs helpers; 
      };

      # --- WSL / Linux Hosts ---
      homeConfigurations.wsl = import ./hosts/wsl/default.nix { 
        inherit inputs helpers; 
      };
    };
}
