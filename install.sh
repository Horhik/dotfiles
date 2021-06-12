
sudo pacman -S  git fakeroot make patch gcc autoconf automake binutils bison stow zsh vim neovim
mkdir -p  ~/Downloads/tmp; cd ~/Downloads/tmp;
pacman -S --needed git base-devel
if [ test ! -f yay ] 
then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
 yay -S dunst
 yay -S firefox
 yay -S dwm
 yay -S surf
 yay -S dmenu
 yay -S st
 yay -S qutebrowser
 yay -S pulsemixer
 yay -S pkg-config
 yay -S variety
 yay -S alacritty
 yay -S compton-tryone-git
 yay -S ninja
 yay -S meson
 yay -S cmake
 yay -S libev
 yay -S libevdev
 yay -S uthash
 yay -S nerd-fonts-mononoki
 yay -S ttf-mononki-git
 yay -S nerd-fonts
 yay -S tmux
 yay -S feh
 yay -S xorg-xsetroot
 yay -S xkblayout-state
 yay -S flameshot
 yay -S cava
 yay -S rustfmt
 yay -S emacs
 yay -S playerctl
 yay -S rofi
 yay -S eww
 yay -S ttf-twemoji
 yay -S ttf-twemoji-color
 yay -S ttf-twemoji
 yay -S alacritty-themes
 yay -S anki
 yay -S clang
 yay -S xkblayout-state-git
 yay -S zathura
 yay -S redshift
 yay -S rustup
 yay -S pfetch
 yay -S xclip
 yay -S tree
 yay -S xorg-xbacklight
 yay -S enact-bin
 yay -S pipewire pipewire-media-session pipewire-pulse
 yay -S acpi xkblayout-state-git
 yay -S obsidian superproductivity nextcloud nextcloud-client
 yay -S nix

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

