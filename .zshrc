alias axl="aws-okta login"
alias ax="aws-okta exec"
autoload -Uz compinit && compinit
PROMPT="%F{10}%B%n@%m%f%b:%F{12}%B%~%f%b$ "
NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export GOPATH="$HOME/go"
export PATH="/usr/local/opt/libpq/bin:$GOPATH/bin:$PATH"
