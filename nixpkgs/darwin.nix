{ pkgs, inputs, ... }:
let
in
{
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/./nixpkgs/configuration.nix";

  nix.package = pkgs.nix;
  nix.gc.automatic = true;

  # homebrew
  homebrew = (pkgs.callPackage ./apps/brew.nix { }).homebrew;

  # cachix
  nix.settings.substituters = [ "https://devenv.cachix.org" ];

  # lorri
  # services.lorri.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
