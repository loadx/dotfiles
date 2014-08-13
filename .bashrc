# override $SHELL
export SHELL=/usr/local/bin/zsh

# COLORS
alias ls='ls -G'
alias ll='ls -hl'
alias be='bundle exec'
alias polipocache='polipo -c /usr/local/etc/polipo/config'

#enables color for iTerm
export TERM=xterm-256color

# standard $PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# homebrew
export HOMEBREWPATH=$(/usr/local/bin/brew --prefix)

#GO
export GOVERSION=$(go version | cut -d " " -f3 | sed "s/go//")
export GOPATH=$(/usr/local/bin/brew --prefix)/Cellar/go/$GOVERSION/bin

# EDITOR
export EDITOR='emacs'

ec () {
    # check if emacs daemon is started, otherwise start it
    pgrep -f 'emacs --daemon' > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        emacs --daemon
    fi

    emacsclient -t $@
}
