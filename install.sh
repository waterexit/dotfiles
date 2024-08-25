#!/bin/bash
function install {
  if $(which $1); then
	if [ -p /dev/stdin ];then
		cat -
	else
		$2
	fi | source
  fi
}

install nvim <<EOS
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
	sudo rm -rf /opt/nvim && 
	sudo tar -C /opt -xzf nvim-linux64.tar.gz &&
	sudo rm nvim-linux64.tar.gz
EOS
