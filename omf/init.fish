set -xg EDITOR vim

set PATH /usr/local/bin $PATH
set PATH /opt/istio/bin $PATH
set PATH $HOME/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.yarn/bin $PATH
set PATH $HOME/.gem/ruby/2.7.0/bin $PATH

set -xg AWS_VAULT_PASS_PREFIX aws-vault
set -xg AWS_VAULT_BACKEND pass

# Load ASDF
source $HOME/.asdf/asdf.fish

test -d /home/linuxbrew/.linuxbrew && eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

starship init fish | source

function ave
    aws-vault exec $argv[1] -- $argv[2..-1]
end

function avl
    aws-vault login $argv[1]
end

function fishcognito
    env fish_history='' fishcognito_active='true' fish
end
