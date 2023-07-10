{ lib, pkgs, homeDirectory, emailAddress }:
let
  amber = rec {
    rootFolder = "${toString homeDirectory}/src/amber";
    coreFolder = "${toString rootFolder}/amber-core";
    cliPath = "${toString coreFolder}/packages/admin-cli";
    email = emailAddress;
  };
in
{
  zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color";
      ll = "ls -la";
      grep = "grep --color=auto --exclude-dir=.csv --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn";
      check_staging = "(cd ${amber.cliPath} && aws-vault exec amber-staging -- npm run start -- staging show)";
      take_staging = "(cd ${amber.cliPath} && aws-vault exec amber-staging -- npm run start -- staging take -e ${amber.email})";
      release_staging = "(cd ${amber.cliPath} && aws-vault exec amber-staging -- npm run start -- staging release -e ${amber.email})";
      admin-cli = "cd ${amber.cliPath}";
    };
    initExtraBeforeCompInit = ''
      # when debugging -> zmodload zsh/zprof
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
      export DIRENV_LOG_FORMAT=''$'\E[38;05;6mdirenv: %s\E[0m'
      export AWS_VAULT_BACKEND="keychain"
      export AWS_FAULT_REGION="ap-southeast-2"
      export AWS_REGION="ap-southeast-2" 
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # nvm auto-load
      autoload -U add-zsh-hook

      load-nvmrc() {
        local nvmrc_path
        nvmrc_path="''$(nvm_find_nvmrc)"

        if [ -n "$nvmrc_path" ]; then
          local nvmrc_node_version
          nvmrc_node_version=$(nvm version "$(cat "''${nvmrc_path}")")

          if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
          elif [ "$nvmrc_node_version" != "''$(nvm version)" ]; then
            nvm use
          fi
        elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "''$(nvm version)" != "''$(nvm version default)" ]; then
          echo "Reverting to nvm default version"
          nvm use default
        fi
      }
      add-zsh-hook chpwd load-nvmrc
      load-nvmrc


      function run-admin-cli() {
      (
        vault_env=''${1}
        src_folder=${amber.coreFolder}
        DURATION=''${DURATION:=15m}

        export DIRENV_LOG_FORMAT=
        if [[ "''${vault_env}" == "amber-production" ]]; then
          echo "-----------------------------"
          echo "✨🌈🔥 PROD MODE #YOLO 🔥🌈✨"
          echo "-----------------------------"

          export REALM=prod
          export TALLY_V2_ORG_ID=get_from_lastpass
          export TALLY_V2_PRIMARY_KEY=get_from_lastpass
          export PRICE_API_ACTUALS_5_MINS_TABLE=prices-five-minutes-actual
          export PRICE_API_FORECAST_5_MINS_TABLE=prices-five-minutes-forecast
          export PRICE_FORECAST_TABLE_NAME=prices-api-prod-PRICE_API_FORECASTS_TABLE
          export PRICE_ACTUALS_TABLE_NAME=prices-api-prod-PRICE_API_ACTUALS_TABLE
          export PRICE_API_LAMBDA_NAME=prices-api-prod-list-prices
          export USAGE_TABLE_NAME=usage-api-prod-USAGE_TABLE
          export USAGE_DATA_S3_WRITER_ARN=arn:aws:lambda:ap-southeast-2:428566834868:function:amber-backend-telemetry-prod-usage-s3-writer
          export TALLY_CHARGE_QUEUE_NAME=ops-tally-charge-prod
          shift
        else
          vault_env=amber-staging
        fi

        direnv allow ''${src_folder} && \
        eval "$(direnv export bash)" && \
        cd ${amber.cliPath} && \
        aws-vault exec ''${vault_env} --duration=''${DURATION} -- npm run start -- ''${@}
      )
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "nvm"
        "git"
        "keychain"
        "ripgrep"
      ];
    };
    zplug = {
      enable = true;

      plugins = [
        { name = "unixorn/warhol.plugin.zsh"; }
        { name = "chisui/zsh-nix-shell"; tags = [ from:github ]; }
      ];
    };
  };
}
