{
  description = "Loadx system configs";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # get out of jail
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, ... }: {
    darwinConfigurations = {
      "Mats-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ 
          home-manager.darwinModules.home-manager
          ./configuration.nix 
        ];
      };
    };
  };
}
