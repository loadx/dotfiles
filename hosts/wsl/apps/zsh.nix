{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      # To customize your prompt, run `p10k configure` or edit ~/.config/p10k.zsh.
      [[ ! -f ~/.config/p10k-config/p10k.zsh ]] || source ~/.config/p10k-config/p10k.zsh
    '';
  };
}
