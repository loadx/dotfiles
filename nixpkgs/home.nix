{ pkgs, enableAmber ? false }:
let
  homeDirectory = /Users/loadx;
  username = "Mat Brennan";
  emailAddress = "mat.brennan@amber.com.au";
  userConfig = (if enableAmber then "_amber" else "");
  /*   
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
    master = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    sha256 = "1s2vy5n2pa7j5zbrzg757hrxccld43pv2lab7x16qnr6d11rw27v";
    }) {}; 
  */
in
{
  # allow non gpl packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    stateVersion = "22.11";
    username = "loadx";
    homeDirectory = pkgs.lib.mkForce homeDirectory;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = (pkgs.callPackage ./apps/zsh${userConfig}.nix { inherit homeDirectory emailAddress pkgs; }).zsh;
  programs.git = (pkgs.callPackage ./apps/git.nix { inherit username emailAddress; }).git;
  programs.tmux = (pkgs.callPackage ./apps/tmux.nix { }).tmux;
  programs.kitty = (pkgs.callPackage ./apps/kitty.nix { }).kitty;
  programs.htop = (pkgs.callPackage ./apps/htop.nix { }).htop;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
    emacs-nox
    zsh
    tmux
    ripgrep
    curl
    wget
    jq
    niv
    htop
    grc
    keychain
    awscli2
    watch
    tree
    rnix-lsp
    aws-vault
    awscli2
    ssm-session-manager-plugin
  ] ++ lib.optionals stdenv.isDarwin [
    # mac only things
    m-cli
  ];
}
