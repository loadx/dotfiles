{ config, pkgs, lib, options, ... }:

with pkgs.stdenv; with lib; {
  imports = [
    <home-manager/nix-darwin>
    #~/.config/nixpkgs/link-apps
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
    pkgs.vim
    pkgs.direnv
    pkgs.nixpkgs-fmt
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  # auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  users.users.loadx = {
    name = "Mat Brennan";
    home = "/Users/loadx";
    shell = pkgs.zsh; 
  };

  home-manager.users.loadx = import ~/.config/nixpkgs/home.nix;
  home-manager.useGlobalPkgs = true;
  services.lorri.enable = true;
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # mac settings
  system.defaults.dock = {
    autohide = true;
    autohide-delay = "0";
    mineffect = "scale";
    orientation = "bottom";
    tilesize = 32;
    expose-group-by-app = false;
  };

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    "com.apple.swipescrolldirection" = false;
    "com.apple.mouse.tapBehavior" = 1;
    "com.apple.trackpad.scaling" = "2.8";
  };

  system.defaults.trackpad = {
    TrackpadRightClick = true;
  };

  #system.defaults.NSGlobalDomain.InitialKeyRepeat = 5;
  #system.defaults.NSGlobalDomain.KeyRepeat = 5;
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";
  system.defaults.spaces.spans-displays = true;

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    taps = [
      "homebrew/cask-fonts"
      "homebrew/cask-drivers"
    ];
    casks = [
      "alt-tab"
      "karabiner-elements"
      "rectangle"
      "kitty"
      "DisplayLink"
      "iterm2"
      "visual-studio-code"
      "pop"
      "microsoft-remote-desktop"
    ];
    brews = [
    ];
  };
}
