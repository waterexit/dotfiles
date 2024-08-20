alias gc="git commit"
alias gca="git commit --amend"
alias ga="git add"
alias gau="git add -u"
alias gap="git add -up"
alias gb="git branch"
alias gch="git checkout"
alias gp="git push"
alias gpf="git push -f"

alias v="nvim"

alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcd="docker compose stop"

function dex() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  docker exec -it "$cid" /bin/bash
 } 

function drm() {
  getopts f options
  if [ "$options" = 'f' ] ; then
    local force='-f'
  fi
  
  local cid
  cid=$(docker ps -a | sed 1d | fzf | awk '{print $1}')

  docker rm ${force} "$cid"
 } 
