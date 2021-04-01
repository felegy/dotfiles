

# Mac DevEnv install



## Set Hostname

Mivel a első telepítés (gyári mód) alapvetően a felhasználók és nem a fejlesztők ígényeire van hangolva és az újabb OS verziókban nem is nagyon lehet a custom telepítési módokat alkalmazni ezért a kész telepítés után kell kézzel megcsinálni mindent, pl. a mindenféle cirkalmas hostnév helyett (amit az OS a felhasználó neve alapján generál) kézzel kell olyan hostnevet beállítani ami nem tartalmaz speciális karaktereket.

El kell indítani a Terminal app-ot: `cmd + space` és `terminal`.

```bash
$ sudo scutil --set ComputerName <hostname>
$ sudo scutil --set LocalHostName <hostname>
```



## Energiatakarékossági és Biztonsági beállítások

Itt még ki lehet térni a teljes drive titkosításra is, de én nem használom a teljes drive titkosítást mert jelnősen lassítja az OS-t és én inkább a win-win megközelítést próbálom alkalmazni, amikor is a drive nincs titkosítva, hanem az érzékeny adataim titkosítását külön oldom (és erre szigorúan ügyelek) meg ott alkalmazok titkosítást ahol indokolt és inkább arra törekszem, hogy nem hagyom őrizetlenül a gépemet, hogy ne férhessen hozzá rajtam kívül más. A lenti beállítésok ahhoz kellenek, hogy a gépen a tűzfal és az energiakezelés megfelelően legyen beállítva, mert pl. az alap beállítás esetén a credential-okat is kiírja az OS a diskre memóriából és emellett még lassan is működik, így mindkét szempontból érdemes ezeket elvégezni: 

```bash
$ sudo pmset -a destroyfvkeyonstandby 1
$ sudo pmset -a hibernatemode 25
$ sudo pmset -a powernap 0
$ sudo pmset -a standby 0
$ sudo pmset -a standbydelay 0
$ sudo pmset -a autopoweroff 0

$ sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
$ sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
$ sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
$ sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
$ sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

$ sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control.plist Active -bool false

$ sudo pkill -HUP socketfilterfw
$ sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist

$ find /var/db/com.apple.xpc.launchd/ -type f -print -exec defaults read {} \; 2>/dev/null
```



## Brew és az alkalmazások beállítása

```bash
$  mkdir ~/.homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew

xcode-select --install

echo 'PATH=$HOME/.homebrew/sbin:$HOME/.homebrew/bin:$PATH' >> .zshrc
echo export HOMEBREW_NO_ANALYTICS=1 >> .zshrc          # biztonsagi opcio
echo export HOMEBREW_NO_INSECURE_REDIRECT=1 >> .zshrc  # biztonsagi opcio
echo export HOMEBREW_CASK_OPTS=--require-sha >> .zshrc # biztonsagi opcio

brew analytics off
brew install --cask iterm2        # Jobb terminal progi

brew install --cask gpg-suite     # gpg (PGP) programcsomag

brew install --cask chromium      # opensource Chrome en ezen fejlesztek

unset HOMEBREW_CASK_OPTS					# a Chrome csomagnak nincs jelenleg SHA hash-e
brew install --cask google-chrome # Sima Chrome 
```



```bash
# Clone this repo to ~/.dotfiles
cd
git clone https://github.com/felegy/dotfiles.git .dotfiles

rm ~/.gnupg/gpg.conf
ln -sn ~/.dotfiles/gpg.conf ~/.gnupg/gpg.conf
rm ~/.gnupg/gpg-agent.conf
ln -sn ~/.dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf

gpg-connect-agent killagent /bye
gpg-connect-agent /bye

# Import GPG public keys
curl https://keybase.io/<keybase_user_name>/pgp_keys.asc | gpg --import
gpg -K

brew install curl
brew link --force curl

brew link --force openssl

brew install vim
brew link --force vim

mkdir -p ~/.vim/{swaps,backup,undo}
ln -sn ~/.dotfiles/vimrc ~/.vimrc

brew install git
brew unlink git && brew link --force git

cat << EOF>> ~/.ssh/config

Host gist.github.com
  Hostname ssh.github.com
  Port 443

Host github.com
  Hostname ssh.github.com
  Port 443
EOF

cat << EOF>> ~/.gitconfig

[include]
        path =  ~/.dotfiles/gitconfig
EOF

git config --global user.name "<user_name>"
git config --global user.email "<email_address>"
git config --global core.editor vim
git config --global core.autocrlf false
git config --global user.signingkey $KEY_ID

```



```bash
$ brew doctor

Please note that these warnings are just used to help the Homebrew maintainers
with debugging if you file an issue. If everything you use Homebrew for is
working fine: please don't worry or file an issue; just ignore this. Thanks!

Warning: The filesystem on /System/Volumes/Data appears to be case-sensitive.
The default macOS filesystem is case-insensitive. Please report any apparent problems.

Warning: Your Homebrew's prefix is not /usr/local.
Some of Homebrew's bottles (binary packages) can only be used with the default
prefix (/usr/local).
You will encounter build failures with some formulae.
Please create pull requests instead of asking for help on Homebrew's GitHub,
Twitter or any other official channels. You are responsible for resolving
any issues you experience while you are running this
unsupported configuration.

```





```bash
brew install php@7.4
brew install composer

brew install nvm

ln -sn ~/.dotfiles/profile.d/nvm.sh ~/.profile.d/100-nvm.sh

nvm install --lts

npm install -g yarn
yarn config set prefix ~/.yarn
ln -sn ~/.dotfiles/profile.d/yarn.sh ~/.profile.d/110-yarn.sh

brew install mysql-client

ln -sn ~/.dotfiles/profile.d/mysql-client.sh ~/.profile.d/120-mysql-client.sh
```





```
brew install lando

brew tap heroku/brew && brew install heroku

ln -sn ~/.dotfiles/profile.d/heroku.sh ~/.profile.d/130-heroku.sh

heroku autocomplete --refresh-cache
```

