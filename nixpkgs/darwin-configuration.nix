{ config, pkgs, ... }:

{
  imports = [ 
    #<home-manager/nix-darwin>
    #./home.nix 
  ];

  environment.systemPackages = with pkgs; [
    vim
    fd
    htop
    watch
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # lorri
  services.lorri.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
    };

    casks = [
      "docker"
      "microsoft-remote-desktop"
      "visual-studio-code"
      "kitty"
      "font-sauce-code-pro-nerd-font"
      "displaylink"
      "pop"
      "zoom"
      "aws-vpn-client"
      "rectangle"
      "alt-tab"
      "postman"
    ];

    brews = [];

    taps = [
    "homebrew/cask-fonts"
    "homebrew/cask-drivers"
    ];    
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
