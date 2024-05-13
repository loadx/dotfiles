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

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let 
      system = "aarch64-darwin";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
      enableAmber = true;
    in {
      darwinConfigurations = {
        "Mats-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [ 
            ./darwin.nix 

            # setup home-manager 
            home-manager.darwinModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.loadx = import ./home.nix {
                  inherit pkgs unstable;
                  homeDirectory = "/Users/loadx/";
                  username = "loadx";
                  emailAddress = "mat.brennan@amber.com.au";
                  enableAmber = enableAmber;
                };
              };
            }
          ];

          specialArgs = { inherit inputs; };
        };
      };
    };
}
