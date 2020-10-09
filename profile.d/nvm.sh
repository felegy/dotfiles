case $(uname) in
    Darwin) BREW_DIR=$HOME/homebrew;;
    *)      BREW_DIR=/home/linuxbrew/.linuxbrew;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_DIR/opt/nvm/nvm.sh" ] && . "$BREW_DIR/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

