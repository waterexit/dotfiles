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
sh <<EOS
    wget https://github.com/microsoft/vscode-js-debug/releases/download/v1.96.0/js-debug-dap-v1.96.0.tar.gz &&
    mkdir -p ~/.local/share/nvim/debug_server &&
    tar -xzf js-debug-dap-v1.96.0.tar.gz -C ~/.local/share/nvim/debug_server &&
    rm -rf js-debug-dap-v1.96.0.tar.gz
EOS
sudo apt install ripgrep
