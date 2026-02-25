{ inputs, helpers, ... }:

inputs.home-manager.lib.homeManagerConfiguration {
  # WSL is usually x86_64, but change to aarch64-linux if on ARM Windows
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  extraSpecialArgs = { inherit inputs; };

  modules = [
    (
      { pkgs, ... }:
      {
        nix = {
          enable = false;
          package = pkgs.nix;
          settings = {
            experimental-features = "nix-command flakes";
          };
        };

        manual = {
          html.enable = false;
          manpages.enable = false;
          json.enable = false;
        };

        home = {
          username = "loadx";
          homeDirectory = "/home/loadx";
          stateVersion = "25.11";
        };

        # --- Shared & Local Imports ---
        imports =
          (helpers.importAllNixFiles { path = ../../apps; })
          ++ (helpers.importAllNixFiles {
            path = ./apps;
          });

        # --- WSL-specific Packages ---
        home.packages = with pkgs; [
          git
        ];

        # Let Home Manager install and manage itself
        programs.home-manager.enable = true;
      }
    )
  ];
}
