{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      core = {
        editor = "code";
      };
      color = {
        ui = true;
      };
      credential = {
        helper = "cache";
      };
      #package = master.git;
      alias = {
        ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat --date=relative'';
        lsd = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'';
        lsr = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'';
        log = ''log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'';
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
}
