
sudo pacman -S  git fakeroot make patch gcc autoconf automake binutils bison stow zsh vim neovim
mkdir -p  ~/Downloads/tmp; cd ~/Downloads/tmp;
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

yay -S dunst firefox dwm surf dmenu st qutebrowser pulsemixer pkg-config variety alacritty compton-tryone-git ninja meson cmake libev  libevdev uthash nerd-fonts-mononoki nerd-fonts tmux feh xorg-xsetroot xkblayout-state flameshot cava rustfmt emacs playerctl rofi eww ttf-twemoji ttf-twemoji-color ttf-twemoji alacritty-themes anki clang xkblayout-state-git zathura redshift rustup pfetch xclip tree  xorg-xbacklight
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

sudo ln -s $HOME/.local/scripts/bin/* /usr/bin

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

git clone https://github.com/elkowar/eww /tmp/eww
cd /tmp/eww
cargo build --release

echo "installing tmp (tmux package manager)"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

