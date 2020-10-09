case $(uname) in
    Darwin) eval $( $HOME/homebrew/bin/brew shellenv);;
    *)      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv);;
esac
