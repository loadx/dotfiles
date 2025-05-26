{
  lib,
  pkgs,
  homeDirectory,
  emailAddress,
}:
let
  initFirst = lib.mkOrder 550 ''
    # when debugging -> zmodload zsh/zprof
    bindkey  "^[[3~"  delete-char
    source ~/.config/p10k-config/p10k.zsh
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
  '';

  initLast = ''
    setopt appendhistory
    setopt INC_APPEND_HISTORY  
    setopt SHARE_HISTORY
    export SAVEHIST=10000 
    export HISTFILE=~/.zsh_history
    source /etc/zshrc.local
    export TERM=xterm-256color
    export DIRENV_LOG_FORMAT=''$'\E[38;05;6mdirenv: %s\E[0m'
  '';
in
{
  zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color";
      ll = "ls -la";
      grep = "grep --color=auto --exclude-dir=.csv --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn";
    };
    history = {
      size = 100000;
    };
    initContent = lib.mkMerge [
      initFirst
      initLast
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "nvm"
        "git"
        "keychain"
        "ripgrep"
        "pyenv"
        "docker"
      ];
    };
    zplug = {
      enable = true;

      plugins = [
        { name = "unixorn/warhol.plugin.zsh"; }
        {
          name = "chisui/zsh-nix-shell";
          tags = [ "from:github" ];
        }
      ];
    };
  };
}
