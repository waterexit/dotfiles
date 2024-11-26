#!/bin/bash
function install {
  if (which $1) ; then
    echo "$1 is arleady installed"
    return
  fi
  echo "$1 installing..."
	if [ -p /dev/stdin ];then
		cat -
	else
		echo $2
	fi | bash
}
sudo apt update
install nvim <<EOS
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
	sudo rm -rf /opt/nvim && 
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	# sudo rm nvim-linux64.tar.gz
EOS
install starship 'curl -sS https://starship.rs/install.sh | sh'
install fzf 'sudo apt install fzf'
install deno 'curl -fsSL https://deno.land/install.sh | sh'
sudo apt install ripgrep
