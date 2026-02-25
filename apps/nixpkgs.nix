{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-powerlevel10k
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
    gh
    nixd
    nixfmt-rfc-style
    devenv
    duckdb
  ];
}
