source ~/.dotfiles/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle docker

antigen bundle command-not-found

antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme
#antigen theme robbyrussell
antigen theme denysdovhan/spaceship-prompt

# Tell antigen that you're done
antigen apply

source ~/.profile
