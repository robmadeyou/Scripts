#!/bin/bash
TOOLS=('vim' 'git' 'gcc' 'g++' 'emacs' 'fortune' 'cowsay' 'zsh' 'php5' 'apache2' 'php5-mysql' 'mysql-client' 'mysql-server' 'curl' )
INSTALL=( );
ELEMENTS=${#TOOLS[@]}

for (( i=0;i<ELEMENTS;i++)); do
	IS=`which ${TOOLS[${i}]}`;
	if [ ! ${IS} ]; then
		echo 'Install' ${TOOLS[${i}]}'?'
		read reply;
		if [ ${reply} = 'y' ]; then
			INSTALL+=(${TOOLS[${i}]});
		elif [ ${reply} = 'N' ]; then
			break;
		fi;
	fi
done;

for(( i=0;i<${#INSTALL[@]};i++)); do
	sudo apt-get install --yes ${INSTALL[${i}]}
done;

#Download zsh and set up configs
curl -L 'https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh' | ZSH=~/.dotfiles/zsh sh
rm -f ~/.zshrc;
wget -O ~/.zshrc 'https://raw.githubusercontent.com/robmadeyou/configs/master/.zshrc';

#Download Vundle and set up plugins / configs
git clone 'https://github.com/VundleVim/Vundle.vim.git' ~/.vim/bundle/Vundle.vim;
rm -f ~/.vimrc;
vim +PluginInstall +qall;
wget -O ~/.vimrc 'https://raw.githubusercontent.com/robmadeyou/configs/master/.vimrc';
vim +PluginInstall +qall;

curl -sS 'https://getcomposer.org/installer' | sudo php -- --install-dir=/bin;
echo "Moving composer to /bin/composer";
sudo mv /bin/composer.phar /bin/composer

