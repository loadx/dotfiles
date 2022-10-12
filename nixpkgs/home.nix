{ config, pkgs, lib, ... }:
let
/*   unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  master = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    sha256 = "1s2vy5n2pa7j5zbrzg757hrxccld43pv2lab7x16qnr6d11rw27v";
  }) {}; */
in {
  home.stateVersion = "22.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "Mat Brennan";
  home.homeDirectory = "/Users/loadx";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color";
      ll = "ls -la";
      grep = "grep --color=auto --exclude-dir=.csv --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn";
      check_staging = "(cd /Users/loadx/src/amber/amber-core/packages/admin-cli && aws-vault exec amber-staging -- npm run start -- staging show)";
      take_staging = "(cd /Users/loadx/src/amber/amber-core/packages/admin-cli && aws-vault exec amber-staging -- npm run start -- staging take -e mat.brennan@amber.com.au)";
      release_staging = "(cd /Users/loadx/src/amber/amber-core/packages/admin-cli && aws-vault exec amber-staging -- npm run start -- staging release -e mat.brennan@amber.com.au)";
      admin-cli = "cd /Users/loadx/src/amber/amber-core/packages/admin-cli";
    };
    initExtraBeforeCompInit = ''
      #when debugging -> zmodload zsh/zprof
      bindkey  "^[[3~"  delete-char
      source ~/.config/p10k-config/p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
    initExtra = ''
      setopt appendhistory
      setopt INC_APPEND_HISTORY  
      setopt SHARE_HISTORY
      export SAVEHIST=10000 
      export HISTFILE=~/.zsh_history
      source /etc/zshrc.local
      export TERM=xterm-256color
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    zplug = {
      enable = true;

      plugins = [
        { name = "plugins/git"; tags = [from:oh-my-zsh]; }
        { name = "plugins/keychain"; tags = [from:oh-my-zsh]; }
        { name = "plugins/ripgrep"; tags = [from:oh-my-zsh]; }
        { name = "unixorn/warhol.plugin.zsh"; }
      ];
    };
  };

  programs.git = {
    enable = true;
    userName = "Mat Brennan";
    userEmail = "mat.brennan@amber.com.au";
    #package = master.git;
    aliases = {
      ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat --date=relative'';
      lsd = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'';
      lsr = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'';
      log = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'';
    };
    extraConfig = {
      core = {
        editor = "code";
      };
      color = {
        ui = true;
      };
    };
    ignores = [
      "*~"
      ".DS_Store"
      "#*#"
      "\#*#"
      "*.pyc"
      ".gems/*"
      ".gems"
      "elpa"
      "quelpa"
    ];
  };

  programs.tmux = {
    enable = true;
    keyMode = "emacs";
    prefix = "C-z";
    shortcut = "z";
    terminal = "screen-256color";
    escapeTime = 0;
    baseIndex = 0;
    extraConfig = ''
      # memorable splits
      bind | split-window -h -c"#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # powerline
      set-option -g status on
      set-option -g status-interval 2
      set-option -g status-justify "left"
      set-option -g status-left-length 160
      set-option -g status-right-length 91
      set -g status-right "#[fg=colour249] %l:%M %P"
      set -g status-left "#[fg=colour117,nobold][#S] "

      set -g window-status-current-format "#[fg=colour0,bg=colour31]#[fg=colour117,bg=colour31] #I  #[fg=colour231,bold]#W #[fg=colour31,bg=colour0,nobold]"
      set -g status-fg colour255
      set -g status-bg colour0 
      #set -g window-status-fg colour249
    '';
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
	font_size 13.5
      	font_family "SauceCodePro Nerd Font Mono Regular"
	cursor #cccccc
	cursor_shape block
	cursor_stop_blinking_after 5.0
	url_color #0087bd
	url_style curly
	open_url_with default
	detect_urls yes
	copy_on_select clipboard
	mouse_map middle release ungrabbed paste_from_selection
	mouse_map left press ungrabbed mouse_selection normal
	mouse_map alt+left press ungrabbed mouse_selection rectangle
	mouse_map left doublepress ungrabbed mouse_selection word
	mouse_map left triplepress ungrabbed mouse_selection line
	mouse_map shift+left press ungrabbed,grabbed mouse_selection normal
	enable_audio_bell no
	draw_minimal_borders yes
	window_margin_width 0
	window_padding_width 1

	# Base16 Harmonic16 Dark - kitty color config
	# Scheme by Jannik Siebert (https://github.com/janniks)
	background #0b1c2c
	foreground #cbd6e2
	selection_background #cbd6e2
	selection_foreground #0b1c2c
	url_color #aabcce
	cursor #cbd6e2
	active_border_color #627e99
	inactive_border_color #223b54
	active_tab_background #0b1c2c
	active_tab_foreground #cbd6e2
	inactive_tab_background #223b54
	inactive_tab_foreground #aabcce
	tab_bar_background #223b54

	# normal
	color0 #0b1c2c
	color1 #bf8b56
	color2 #56bf8b
	color3 #8bbf56
	color4 #8b56bf
	color5 #bf568b
	color6 #568bbf
	color7 #cbd6e2

	# bright
	color8 #627e99
	color9 #bfbf56
	color10 #223b54
	color11 #405c79
	color12 #aabcce
	color13 #e5ebf1
	color14 #bf5656
	color15 #f7f9fb

        background_opacity .97
	dynamic_background_opacity no
    '';
  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
    emacs-nox
    zsh
    oh-my-zsh
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
    fd
    watch
    tree
  ] ++ lib.optionals stdenv.isDarwin [
    # mac only things
    m-cli
  ];
}
