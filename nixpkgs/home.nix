{ pkgs, unstable, homeDirectory, username, emailAddress, enableAmber ? false, }:
let
  userConfig = (if enableAmber then "_amber" else "");
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    stateVersion = "23.11";
    homeDirectory = pkgs.lib.mkForce homeDirectory;
  };

  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
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

  # things non-specific to any system/arch
  home.packages = with pkgs; [
    zsh-powerlevel10k
    emacs-nox
    ripgrep
    curl
    wget
    jq
    niv
    grc
    keychain
    watch
    tree
    ipcalc
    postgresql
    vim
    fd
    watch
    gh
    nixd
    unstable.devenv
  ];
}
