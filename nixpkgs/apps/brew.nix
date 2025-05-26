{ lib }:

{
  homebrew = {
    enable = true;
    user = "loadx";
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
    };

    casks = [
      "altair-graphql-client"
      "docker"
      "windows-app"
      "visual-studio-code"
      "kitty"
      "font-sauce-code-pro-nerd-font"
      "displaylink"
      "pop"
      "zoom"
      "aws-vpn-client"
      "rectangle"
      "alt-tab"
      "postman"
      "mockoon"
      "monitorcontrol"
      "jd-gui"
      "dbeaver-community"
      "openvpn-connect"
      "plex"
      "postman"
      "snowflake-snowsql"
      "slack"
      "the-unarchiver"
      "utm"
      "vyprvpn"
      "session-manager-plugin"
      "notunes"
      "spotify"
      "sony-ps-remote-play"
      "tailscale"
    ];

    brews = [
      "git"
      "grc"
      "libfaketime"
      "pipx"
      "aws-vault"
      "awscli"
      "watchman"
      "sqlfluff"
      "yarn"
      "aws-sam-cli"
      "fnm"
    ];

    taps = [
      #"cask-font"
      #"cask-drivers"
      #"cask-versions"
    ];
  };
}
