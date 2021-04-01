case $(uname) in
    Darwin) BREW_DIR=$HOME/.homebrew;;
    *)      BREW_DIR=/home/linuxbrew/.linuxbrew;;
esac
export PATH="$BREW_DIR/opt/mysql-client/bin:$PATH"
