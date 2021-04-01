case $(uname) in
    Darwin) eval $( $HOME/.homebrew/bin/brew shellenv);;
    *)      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv);;
esac

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

