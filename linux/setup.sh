#!/bin/bash

LOCAL_CONFIG="$HOME/.config/shell/local.sh"

declare -a common_packages=(
	curl wget git vim bat fzf eza jq ripgrep zoxide unzip neovim helix
)

# install_arch() {
# 	sudo pacman -S --noconfirm "${common_packages[@]}" github-cli fd git-delta lazygit wl-clipboard topgrade
# }

install_debian() {
	sudo apt install "${common_packages[@]}" gh fd-find xclip autorandr nala topgrade
	sudo ln -sfnv /usr/bin/fdfind /usr/bin/fd
	sudo ln -sfnv /usr/bin/batcat /usr/bin/bat
	echo "alias cat=batcat" >>"$LOCAL_CONFIG"
}

install_termux() {
	pkg install "${common_packages[@]}" gh fd git-delta openssh termux-tools nala
	ln -sfnv "$PWD/../config/bin" "$HOME"/bin
	cp -rv "$PWD/../config/.termux" "$HOME"/
}

get_system_info() {
	[ -e /etc/os-release ] && source /etc/os-release && echo "${ID:-Unknown}" && return
	[ -e /etc/lsb-release ] && source /etc/lsb-release && echo "${DISTRIB_ID:-Unknown}" && return
	[ "$(uname -o)" == "Android" ] && echo "termux" && return
}

install_packages() {
	system_kind=$(get_system_info)
	echo -e "\u001b[7m Installing packages for $system_kind...\u001b[0m"

	case $system_kind in
	arch) ./arch/install.sh ;;
	ubuntu) ./debian/install.sh ;;
	debian) install_debian ;;
	termux) install_termux ;;
	*) echo "Unknown system!" && exit 1 ;;
	esac

	mkdir -p "$HOME/.local/state/vim/undo"
}

install_oh_my_zsh() {
	echo -e "\u001b[7m Installing oh-my-zsh...\u001b[0m"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	echo -e "\u001b[7m Installing zsh plugins...\u001b[0m"
	gh="https://github.com/"
	# omz="$ZDOTDIR/ohmyzsh/custom"
	omz_plugin="$HOME/.oh-my-zsh/custom/plugins/"

	cd "$omz_plugin" || exit
	git clone "$gh/zsh-users/zsh-autosuggestions"
	git clone "$gh/zsh-users/zsh-completions"
	git clone "$gh/zsh-users/zsh-history-substring-search"
	git clone "$gh/zsh-users/zsh-syntax-highlighting"
	git clone "$gh/djui/alias-tips"
	git clone "$gh/unixorn/git-extra-commands"
	git clone "$gh/Aloxaf/fzf-tab"
	git clone "$gh/hlissner/zsh-autopair"
	# git clone "$gh/marlonrichert/zsh-autocomplete"
	cd - || exit

	chsh -s /usr/bin/zsh
}

install_extras() {
	install_oh_my_zsh
}

declare -a config_dirs=(
	"bat" "delta" "fish" "gitignore.global" "lazygit" "shell" "tmux" "zsh"
)

declare -a home_files=(
	"zsh/.zshenv" ".bashrc" ".dircolors" ".gitconfig" ".inputrc" ".luarc.json"
	".stylua.toml" ".typos.toml" ".vimrc"
)

backup_configs() {
	echo -e "\u001b[33;1m Backing up existing files... \u001b[0m"
	for dir in "${config_dirs[@]}"; do
		mv -v "$HOME/.config/$dir" "$HOME/.config/$dir.old"
	done
	for file in "${home_files[@]}"; do
		mv -v "$HOME/$file" "$HOME/$file.old"
	done
	echo -e "\u001b[36;1m Done backing up files as '.old'! . \u001b[0m"
}

setup_symlinks() {
	echo -e "\u001b[7m Setting up symlinks... \u001b[0m"
	for dir in "${config_dirs[@]}"; do
		ln -sfnv "$PWD/config/$dir" "$HOME/.config/"
	done
	for file in "${home_files[@]}"; do
		ln -sfnv "$PWD/config/$file" "$HOME"/
	done
}

setup_dotfiles() {
	echo -e "\u001b[7m Setting up dots2k... \u001b[0m"
	install_packages
	install_extras
	backup_configs
	setup_symlinks
	echo -e "\u001b[7m Done! \u001b[0m"
}

show_menu() {
	echo -e "\u001b[32;1m Setting up your env with dots2k...\u001b[0m"
	echo -e " \u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
	echo -e "  \u001b[34;1m (0) Setup Everything \u001b[0m"
	echo -e "  \u001b[34;1m (1) Install Packages \u001b[0m"
	echo -e "  \u001b[34;1m (2) Install Extras \u001b[0m"
	echo -e "  \u001b[34;1m (3) Backup Configs \u001b[0m"
	echo -e "  \u001b[34;1m (4) Setup Symlinks \u001b[0m"
	echo -e "  \u001b[33;1m (*) Anything else to exit \u001b[0m"
	echo -en "\u001b[32;1m ==> \u001b[0m"

	read -r option
	case $option in
	0) setup_dotfiles ;;
	1) install_packages ;;
	2) install_extras ;;
	3) backup_configs ;;
	4) setup_symlinks ;;
	*) echo -e "\u001b[32;1m alvida and adios! \u001b[0m" && exit 0 ;;
	esac
}

main() {
	case "$1" in
	-a | --all | a | all) setup_dotfiles ;;
	-i | --install | i | install) install_packages && install_extras ;;
	-s | --symlinks | s | symlinks) setup_symlinks ;;
	*) show_menu ;;
	esac
	exit 0
}

main "$@"
