# turn off the damn greeting
set fish_greeting

# rg
if command -v fzf &> /dev/null && command -v rg &> /dev/null
  set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
end

# gpg
set -gx GPG_TTY (tty)
# set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

alias n="nvim"
alias e="emacsclient"

set -gx COLORTERM '24bit'

if status is-interactive
  set -gx EDITOR 'emacsclient -t'
  set -gx VISUAL 'emacsclient -t'
end

if type -q direnv
  eval (direnv hook fish)
end

if type -q go
  set -U fish_user_paths $HOME/bin (go env GOPATH)/bin
else
  set -U fish_user_paths $HOME/bin
end

if type -q starship
  starship init fish | source
end

if type -q z
  source (z --init fish enhanced | psub)
  alias zz="z -c"
  alias zi="z -i"
  alias zf="z -I"
  alias zb="z -b"
end
