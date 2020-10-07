
sudo pacman -S  git fakeroot make patch gcc autoconf automake binutils bison stow zsh vim neovim
mkdir -p  ~/Downloads/tmp; cd ~/Downloads/tmp;
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

yay -S dunst firefox dwm surf dmenu st qutebrowser pulsemixer pkg-config variety alacritty compton-tryone-git ninja meson cmake libev  libevdev uthash nerd-fonts-mononoki nerd-fonts tmux feh xorg-xsetroot
# setup compositor
cd $HOME/Downloads/tmp
git clone https://github.com/ibhagwan/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

 ~/.vim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


 sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
