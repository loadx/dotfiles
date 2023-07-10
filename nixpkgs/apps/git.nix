{ lib, pkgs, username, emailAddress }:

{
  git = {
    enable = true;
    userName = "${username}";
    userEmail = "${emailAddress}";
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
}