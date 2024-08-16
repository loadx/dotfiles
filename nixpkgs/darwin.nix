{ pkgs, inputs, ... }:
let
  nvmWrapped = pkgs.callPackage ./apps/nvm.nix { };
in
{
  nix.useDaemon = true;


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/./nixpkgs/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.gc.automatic = true;

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
      "mockoon"
      "jd-gui"
      "dbeaver-community"
      "openvpn-connect"
      "plex"
      "postman"
      "snowflake-snowsql"
      "slack"
      "the-unarchiver"
      "utm"
      "vyprvpn"
      "session-manager-plugin"
    ];

    brews = [
      "libfaketime"
      "pipx"
      "aws-vault"
      "pyenv"
      "awscli"
    ];

    taps = [
      "homebrew/cask-fonts"
      "homebrew/cask-drivers"
      "homebrew/cask-versions"
    ];
  };

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

