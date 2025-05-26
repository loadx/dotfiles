{
  pkgs,
  homeDirectory,
  username,
  emailAddress,
  gitFullName,
  config,
  enableAmber ? false,
}:
let
  userConfig = (if enableAmber then "_amber" else "");
in
/*
  configDir = config.xdg.configHome;
    overrideConfigFiles = (configMap:
    builtins.mapAttrs
      (outFile: sourceFile:
        pkgs.lib.mkForce { source = config.lib.file.mkOutOfStoreSymlink sourceFile; }
      )
      configMap
  );
*/
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    stateVersion = "25.05";
    homeDirectory = pkgs.lib.mkForce homeDirectory;
    /*
      file = overrideConfigFiles {
        "${configDir}/kitty/kitty.conf" = /Users/loadx/kitty.conf;
      };
    */
  };

  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh =
    (pkgs.callPackage ./apps/zsh${userConfig}.nix { inherit homeDirectory emailAddress pkgs; }).zsh;
  programs.git = (pkgs.callPackage ./apps/git.nix { inherit gitFullName emailAddress; }).git;
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
    (emacs.override { withNativeCompilation = false; })
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
    nixfmt-rfc-style
    devenv
  ];
}
