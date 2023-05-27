alias ax="aws-vault exec"
autoload -Uz compinit && compinit
PROMPT="%F{10}%B%n@%m%f%b:%F{12}%B%~%f%b$ "
NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export GOPATH="$HOME/go"
export PATH="/usr/local/opt/libpq/bin:$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
