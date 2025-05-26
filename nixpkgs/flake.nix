{
  description = "Loadx system configs";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    # get out of jail
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
      enableAmber = true;
    in
    {
      darwinConfigurations."Mats-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin.nix

          # setup home-manager
          home-manager.darwinModules.home-manager
          rec {
            home-manager = rec {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.loadx = (
                self:
                import ./home.nix {
                  inherit pkgs; # unstable;
                  homeDirectory = "/Users/loadx/";
                  username = "loadx";
                  emailAddress = "mat.brennan@amber.com.au";
                  gitFullName = "Mat Brennan";
                  enableAmber = enableAmber;
                  config = self.config;
                }
              );
            };
          }
        ];

        specialArgs = { inherit inputs; };
      };

      darwinPackages = self.darwinConfigurations."Mats-MacBook-Pro".pkgs;
    };
}
