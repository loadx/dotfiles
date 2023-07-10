{ lib }:

{
  tmux = {
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
}